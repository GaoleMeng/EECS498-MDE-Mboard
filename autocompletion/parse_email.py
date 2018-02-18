import mailbox
import html
import re
import logging
BRAD_EMAIL = "Bradley Ebenhoeh <bradeben@umich.edu>"
BEST_SIGNATURE = "Best,"
BRAD_SIGNATURE = "BCE"
BRAD_SIGNATURE1 = "Bradley C Ebenhoeh"
BRAD_SIGNATURE2 = "B.C.E"
ATTACHMENT_SIGNATURE = "Attachment available until"
FORWARD_SIGNATURE = "---------- Forwarded message ----------"
HTML_SIGNATURE = "<html>"
IS_DEBUG = True

remove_html = lambda x: re.sub(r'http\S+', ' ', x)
def printd(string, *args, **kwargs):
    if IS_DEBUG:
        print(string, *args, **kwargs)

def parse_mbox(filename = "data/email.mbox", outfilename = "data/parsed_email.txt"):
    cnt = 0
    mbox = mailbox.mbox(filename)
    with open(outfilename, "w") as outfile:
        for message in mbox:
            if message["From"] == BRAD_EMAIL:
                try:
                    printd(cnt, end="\r")
                    cnt += 1
                    text = clean_text(str(get_message(message)))
                    outfile.write(text.strip() + "\n")
                except Exception as e:
                    printd("Exception:", e)

    print("%s sent emails write!" % cnt)

def clean_text(text):
    assert isinstance(text, str)
    import string
    text = html.unescape(text)
    if BEST_SIGNATURE in text:
        text = text[:text.index(BEST_SIGNATURE)]
    if BRAD_SIGNATURE in text:
        text = text[:text.index(BRAD_SIGNATURE)]
    if BRAD_SIGNATURE1 in text:
        text = text[:text.index(BRAD_SIGNATURE1)-1]
    if BRAD_SIGNATURE2 in text:
        text = text[:text.index(BRAD_SIGNATURE2)]
    if ATTACHMENT_SIGNATURE in text:
        text = text[:text.index(ATTACHMENT_SIGNATURE)]
    if FORWARD_SIGNATURE in text:
        text = text[:text.index(FORWARD_SIGNATURE)]
    if HTML_SIGNATURE in text:
        text = text[:text.index(HTML_SIGNATURE)]
    text = remove_html(text)
    text = text.replace("\r", "").replace("\n", " ").strip().strip(string.punctuation)
    assert isinstance(text, str)
    return text
def get_message(message):
    if message.is_multipart():
        for part in message.get_payload():
            if part.is_multipart():
                for subpart in part.walk():
                    # Multi part -> only need the first message
                    if subpart.get_content_type() == "text/plain":
                        return subpart.get_payload()


            else:
                if part.get_content_type() == "text/plain":
                    return part.get_payload()
    else:
        return message.get_payload()



if __name__ == "__main__":
    parse_mbox()