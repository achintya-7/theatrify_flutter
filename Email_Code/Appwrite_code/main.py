key_news = "75b9d11fc15a49f59a575c9bb0aa8fb0"
key_email = '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'

import random
from newsapi import NewsApiClient
from sendgrid import SendGridAPIClient
from sendgrid.helpers.mail import Mail
from appwrite.client import Client
from appwrite.services.database import Database

# COLLECTING OF EMAILS FROM THE DATABASE
client = Client()

(client.set_endpoint('https://35.226.27.103/v1')  # Your API Endpoint
 .set_project('61eafcf28a615a64f0df')  # Your project ID
 .set_key(
     '0b58bd7ae0457d2f264b512a3c9c1a99f7758ddac0266ab1ede8539dbeee910a3d281a97ce65f79c6125dc1fd7f942495b3d25a1638152307caafd2850db2cc74d89c53a03c140b1408a5fd8f09b9084fff0720d9f6d9ed721604f0c382e68b3707a69ceb1f170e79e02e3bb8689272fb495336bcc9831b969d363ec334846ad'
 ).set_self_signed()  # Your secret API key
 )

database = Database(client)

result = database.list_documents('61eafd364852a5bccadb')
result2 = result['documents']
email_ids = []

for i in range(result['sum']):
    email_ids.append(result2[i]['emails'])

# GETTING THE NEWS
newsapi = NewsApiClient(api_key=key_news)

data = newsapi.get_everything(
    q='theatre',
    language='en',
    sort_by='relevancy',
)

articles = data['articles']
results = data['totalResults']

num = random.randint(0, 16)

title = articles[num]["title"]
content = articles[num]["content"]
url_article = articles[num]["url"]
url_image = articles[num]["urlToImage"]

# HTML TEMPLATE TO DISPLAY THE NEWS IN THE EMAIL
html_template = f"""
<center>
    <p style="font-size: 48px;"> {title} <p>
</center> <br> 
<center> 
    <img src={url_image}> <br>
</center>

<p style="font-size: 24px;"> {content} </p> <br>

<center> <a href={url_article}> <button style="font-size: large;">Full Article</button> </a> </center>
"""

print(email_ids)

# SENDING OF EMAIL
for ids in email_ids:
    message = Mail(from_email='achintya.x7.1@gmail.com',
                   to_emails=ids,
                   subject='your daily theatre news',
                   html_content=html_template)

    try:
        sg = SendGridAPIClient(key_email)
        response = sg.send(message)
        print(f'email sent : {ids}')
    except Exception as e:
        print(e)