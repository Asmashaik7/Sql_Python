#view weather details

@secondapp.route("/weather")
def contact_us():
    url="https://api.openweathermap.org/data/2.5/forecast/daily?q=vijayawada,in&cnt=10&mode=json&units=metric&APPID=2d80cf7142a085e6c34f383205d35118"
    resp=requests.get(url)
    data=resp.text
    for each_dict in weather:
        print("date :",each_dict.get('dt'),"\t","min :",each_dict.get('min'))

if __name__ = '__main__':
    secondapp.run(debug=True, port=7000)

