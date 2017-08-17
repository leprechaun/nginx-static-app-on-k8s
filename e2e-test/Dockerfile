FROM python:2.7

RUN pip install selenium==3.3

ADD test.py /usr/local/bin/selenium-runner
RUN chmod 755 /usr/local/bin/selenium-runner

CMD selenium-runner
