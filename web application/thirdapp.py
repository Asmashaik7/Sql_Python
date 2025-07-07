from flask import Flask,render_template
# create a Name space for our application

thirdapp=Flask(__name__)

# Homepage
@thirdapp.route("/")
def home_page():
    return render_template("homepage.html")


if __name__=='__main__':
    thirdapp.run(debug=True, port=5001)