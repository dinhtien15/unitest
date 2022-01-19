FROM python:3
WORKDIR /usr/scr/app
RUN docker pull santhoshkdhana/flask-calculator-beginner:latest
RUN docker container run -d -p 5000:5000 --name=santyflask flask-calculator-beginner
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 5000
CMD ["python","app.py"]
