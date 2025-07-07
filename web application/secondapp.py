from flask import Flask
# create a Name space for our application

secondapp=Flask(__name__)

# Homepage
@secondapp.route("/")
def home_page():
    return"""<h1>Welcome to my app, Love Mew.</h1>
    <p>


Here, you’ll find some of the interesting things about kittens. The cat (Felis catus), also referred to as the domestic cat or house cat, is a small domesticated carnivorous mammal. It is the only domesticated species of the family Felidae. Advances in archaeology and genetics have shown that the domestication of the cat occurred in the Near East around 7500 BC. It is commonly kept as a pet and working cat, but also ranges freely as a feral cat avoiding human contact. It is valued by humans for companionship and its ability to kill vermin. Its retractable claws are adapted to killing small prey species such as mice and rats. It has a strong, flexible body, quick reflexes, and sharp teeth, and its night vision and sense of smell are well developed. It is a social species, but a solitary hunter and a crepuscular predator.
These baby animals are curious creatures, and you can often find them hugging, ambushing and licking people and objects.
Below are some cute pictures of kittens...
</p>
<img src="https://wallup.net/wp-content/uploads/2018/10/06/708179-kittens-kitten-cat-cats-baby-cute-s.jpg" id="img" style="width: 496px; height: 404px;">
<img src="https://wallpapercave.com/wp/wp8555532.jpg" id="img" style="width: 496px; height: 310px;">
<img src="https://www.warrenphotographic.co.uk/photography/bigs/10113-Three-cute-kittens-white-background.jpg" id="img" style="width: 496px; height: 355px;">

<p>Cat intelligence refers to a cat’s ability to solve problems, adapt to its environment, learn new behaviors, and communicate its needs. Structurally, a cat’s brain shares similarities with the human brain,[1] containing around 250 million neurons in the cerebral cortex, which is responsible for complex processing.[2] Cats display neuroplasticity, allowing their brains to reorganize based on experiences. They have well-developed memory retaining information for a decade or longer. These memories are often intertwined with emotions, allowing cats to recall both positive and negative experiences associated with specific places.[3] While they excel in observational learning and problem-solving, studies conclude that they struggle with understanding cause-and-effect relationships in the same way that humans do.</p1>

<a href="http://127.0.0.1:7777/aboutus">About us</a>

<a href="http://127.0.0.1:7777/services">Services</a>

<a href="http://127.0.0.1:7777/contactus">Contact us</a>

<a href="https://www.gettyimages.in/photos/cute-little-kittens">Getty images</a>
"""

# About us
@secondapp.route("/aboutus")
def aboutus_page():
    return"""<h3>About us</h3>
    <p>Love Mew (LoveMew.com, Inc.) is cat lovers' site dedicated to spreading the meowsage of love for our feline friends. We publish the latest news and original stories on cats, kittens and cat rescue.

Our original stories have been featured in prominent publishers such as people.com, metro.co.uk, boredpanda.com, onegreenplanet.org, ladbible.com, and many more.

Thank you so much for stopping by. If you have a story that you'd like to share with us, you can write to us at contact@lovemeow.com . We are always happy to hear from you.


If you want to see cute kitten images on getty, here you go..<a href="https://www.gettyimages.in/photos/cute-little-kittens">Getty images</a>
    
<h4>More info:</h4>
Mailing address: P.O. Box 11234 TG India

Email: contact@lovemew.com</p>
    
    <a href="http://127.0.0.1:7777/">Home</a>

    <a href="http://127.0.0.1:7777/services">Services</a>

    <a href="http://127.0.0.1:7777/contactus">Contact us</a>

    
    """

# Services
@secondapp.route("/services")
def service_page():
    return"""<h3>Our Services</h3>

    <!DOCTYPE html>
<html>
<body>

<h1>HTML Emoji Example</h1>

<h2>&#128512;</h2>

</body>
</html>
<p><h3>Origin and history of cats</h3>
After the nonavian dinosaurs became extinct, mammals became the dominant life forms. The first felinelike mammal, Proailurus, evolved about 30 million years ago. It is thought that all true cat species evolved from this small civetlike predator.

Cats that resemble today’s felids first appeared in the early Pliocene Epoch (5.3 to 3.6 million years ago), and they have continued into present times with remarkably few changes. The original design of fang and claw, flexible backbone, muscular strength, and agility allowed felids to survive and adapt to the changes brought by each new era. Adaptations have occurred with changes in prey, but the basic body type has stayed the same.</p1>
</p>
     <a href="http://127.0.0.1:7777/">Home</a>

    <a href="http://127.0.0.1:7777/aboutus">About Us</a>

    <a href="http://127.0.0.1:7777/contactus">Contact us</a>


    
    
    """

# Contact us
@secondapp.route("/contactus")
def contact_page():
    return"""<h3>Contact us</h3>

    <!DOCTYPE html>
<html>
<body>

<h1>HTML Emoji Example</h1>

<h2>&#128509;</h2>

</body>
</html>

<!DOCTYPE html>
<html>
<body>

<h2>HTML Forms</h2>

<form action="/action_page.php">
  <label for="fname">First name:</label><br>
  <input type="text" id="fname" name="fname" value="John"><br>
  <label for="lname">Last name:</label><br>
  <input type="text" id="lname" name="lname" value="Doe"><br><br>
  <input type="submit" value="Submit">
</form> 

<p>If you click the "Submit" button, the form-data will be sent to a page called "/action_page.php".</p>

</body>
</html>
    
    <a href="http://127.0.0.1:7777/">Home</a>

    <a href="http://127.0.0.1:7777/aboutus">About Us</a>

    <a href="http://127.0.0.1:7777/services">Services</a>

    
    
    
    """





if __name__=='__main__':
    secondapp.run(debug=True, port=7777)

