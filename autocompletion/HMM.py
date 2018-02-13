import autocomplete
from autocomplete import models

# with open("data/parsed_email.txt") as infile:
#     data = "\n".join(infile.readlines())
#
# models.train_models(data)
autocomplete.run_server()
