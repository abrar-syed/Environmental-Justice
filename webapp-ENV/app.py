
from flask import Flask, render_template,request, jsonify
import pymysql.cursors
import json
from decimal import Decimal

class fakefloat(float):
    def __init__(self, value):
        self._value = value
    def __repr__(self):
        return str(self._value)

def defaultencode(o):
    if isinstance(o, Decimal):
        # Subclass float with custom repr?
        return fakefloat(o)
    raise TypeError(repr(o) + " is not JSON serializable")

# Connect to the database
connection = pymysql.connect(host='localhost',
                             user='root',
                             password='abrar1312',
                             db='CA_CAP_TRADE',
                             charset='utf8mb4',
                             cursorclass=pymysql.cursors.DictCursor)
app = Flask(__name__, static_url_path='/static', template_folder='./templates')

@app.route("/", methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        county = request.form.get('cname')
        print(county)
        cur = connection.cursor()
        query = """\
            SELECT CS.Avg_Val, County_Name, SUM(CASE WHEN SB535_DAC = "Yes"
            THEN 1 ELSE 0 END) AS SB535_DAC,
        SUM(CASE WHEN AB_1550_Low_Income = "Yes"
            THEN 1 ELSE 0 END) AS Low_Income
    FROM\
        (SELECT Census_ID, County_Name, SB535_DAC, AB_1550_Low_Income
        FROM CENSUS_TRACT T
        WHERE SB535_DAC != ""
    ) AS TB
        LEFT OUTER JOIN (SELECT Census_ID, AVG(Value) AS Avg_Val
        FROM CES
        GROUP BY Census_ID) CS
        ON CS.Census_ID = TB.Census_ID
    WHERE County_Name LIKE '%{0}%'""".format(county)
        cur.execute(query)
        result = cur.fetchone()
        val = int(result['Avg_Val'])
        sb = int(result['SB535_DAC'])
        li = int(result['Low_Income'])
    else:
        val = 0
        sb =0
        li = 0
    return render_template('index.html', val=val, sb=sb, li=li)

@app.route('/CI', methods=['GET', 'POST'])
def C_I():
    results = []
    if request.method == "POST":
        county = request.form.get('cname')
        cur = connection.cursor()
        query = """\
            SELECT Project_Type, Date, Credits, Project_Name, Project_Operator FROM GHG_OFFSET_CREDITS""".format(county)
        cur.execute(query)
        results = cur.fetchall()
        print(results[0])
    return render_template('page2.html', results=results)

@app.route('/Demo', methods=['GET', 'POST'])
def Demo():
    haw = 0
    pov = 0
    AI = 0
    pop = 0
    wht = 0
    oth = 0
    asn = 0
    blk = 0
    hisp = 0
    var = 0
    if request.method == "POST":
        county = request.form.get('cname')
        cur = connection.cursor()
        query = """\
                    SELECT CS.Avg_Pov, CS.Avg_Pop, CS.AVG_White,CS.Avg_Black, CS.Avg_AI, CS.Avg_Asian, CS.Avg_Hawaiian, CS.Avg_Hispanic, CS.Avg_Other, CS.Avg_Var, County_Name
        FROM
            (SELECT Census_ID, County_Name, SB535_DAC, AB_1550_Low_Income
            FROM CENSUS_TRACT T
            WHERE SB535_DAC != ""
        ) AS TB
            LEFT OUTER JOIN (SELECT Census_ID, AVG(Poverty) AS Avg_Pov, AVG(Total_pop) as Avg_Pop, AVG(WHITE) as Avg_White, AVG(Black) as Avg_Black, AVG(American_indian)as Avg_AI,
                                    AVG(Asian) AS Avg_Asian , AVG(Hawaiian) as Avg_Hawaiian , AVG(Hispanic) as Avg_Hispanic, AVG(Other) as Avg_Other, AVG(Two_or_more) as Avg_Var
            FROM RACE
            GROUP BY Census_ID) CS
            ON CS.Census_ID = TB.Census_ID
        WHERE County_Name LIKE '%{0}%'
        GROUP BY County_Name""".format(county)
        cur.execute(query)
        result = cur.fetchone()
        print(result)
        haw = int(result['Avg_Hawaiian'])
        pov = int(result['Avg_Pov'])
        AI = int(result['Avg_AI'])
        pop = int(result['Avg_Pop'])
        wht = int(result['AVG_White'])
        oth = int(result['Avg_Other'])
        asn = int(result['Avg_Asian'])
        blk = int(result['Avg_Black'])
        hisp = int(result['Avg_Hispanic'])
        var = int(result['Avg_Var'])

    return render_template('page3.html', haw=haw, pov=pov, AI=AI, pop=pop, wht=wht, oth=oth, asn=asn, blk=blk, hisp=hisp, var=var)




if __name__ == "__main__":
    app.run(debug=True)