import _pickle as pickle
from bottle import run, route, debug
import operator
import json

import requests


import sys
NUM_PRED = 4
NUM_TIMEOUT = 50000
class autocompletion:
    def __init__(self, unigram, bigram, trigram):
        self.unigram = unigram
        self.bigram = bigram
        self.trigram = trigram
        self._sort()

    def _sort(self):
        self.unigram = [k for k, _ in sorted(self.unigram.items(), key=operator.itemgetter(1), reverse=True)][:NUM_TIMEOUT]
        self.bigram = {k: [_k for _k, _ in sorted(v.items(), key=operator.itemgetter(1), reverse=True)[:NUM_PRED]] for
                       k, v in self.bigram.items()}
        self.trigram = {k: [_k for _k, _ in sorted(v.items(), key=operator.itemgetter(1), reverse=True)[:NUM_PRED]] for
                        k, v in self.trigram.items()}

    def predict_next_trigram(self, word1, word2):
        to_return = []
        tri_key = word1 + "\t" + word2
        trigram_result = self.trigram.get(tri_key)
        if trigram_result:
            if len(trigram_result) == NUM_PRED:
                return trigram_result
            else:
                to_return += trigram_result

        bigram_result = self.bigram.get(word2)
        if bigram_result:
            if len(to_return) + len(bigram_result) >= NUM_PRED:
                return to_return + bigram_result[:NUM_PRED - len(to_return)]
            else:
                to_return += bigram_result
        return to_return + self.unigram[:NUM_PRED - len(to_return)]

    def predict_next_bigram(self, word):
        bigram_result = self.bigram.get(word)
        if bigram_result:
            if len(bigram_result) == NUM_PRED:
                return bigram_result
            else:
                return bigram_result + self.unigram[:NUM_PRED - len(bigram_result)]

    def complete_bigram(self, word):
        to_return = []
        for i in self.unigram:
            if i.startswith(word):
                to_return.append(i)
                if len(to_return) == 4:
                    return to_return
        return to_return

    def parse(self, words):
        words = words.rstrip()
        words_split = words.split("_")
        if words[-1] != "_":
            return self.complete_bigram(words_split[-1])
        else:
            if len(words_split) == 3:
                return self.predict_next_trigram(words_split[0], words_split[1])
            else:
                return self.predict_next_bigram(words_split[0])



def run_server(port_num=8080):
    """little demo server for demo'ing sake"""
    model = pickle.load(open("autocompletion/data/temp.model", "rb"))

    try:
        r = requests.get('http://localhost:3000/auto_complete_connect', auth=('user', 'pass'))
    except:
        pass

    debug(True)

    @route('/<word>')
    def index(word):
        if word == "!exit":
            pass
            # sys.stderr.close()
        results = model.parse(word)

        return json.dumps({"pred": ";".join(results)})


    run(host='localhost', port=port_num)

run_server()

