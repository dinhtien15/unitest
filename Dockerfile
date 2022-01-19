FROM python:3
WORKDIR /usr/scr/app
RUN docker pull santhoshkdhana/flask-calculator-beginner:latest
RUN docker container run -d -p 5000:5000 --name=santyflask flask-calculator-beginner
RUN ["rm", "-f", "/etc/localtime"]
RUN ["ln", "-s", "/usr/share/zoneinfo/Asia/Ho_Chi_Minh", "/etc/localtime"]
RUN echo "nameserver 8.8.8.8" >> /etc/resolv.conf
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 5000
CMD ["python","app.py"]
