from flask import Flask
# create a Name space for our application
firstapp = Flask(__name__)

# @firstapp.route("/") - Router function
# Router Decorator - create URLs using this decorator
@firstapp.route("/")
def hello_world():
    return """Hello world, this is Asma"""


if __name__=='__main__':
    firstapp.run(debug=True)