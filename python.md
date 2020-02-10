# Python
## Jupyter 

### jupyterlab-vim

[jwkvam/jupyterlab-vim](https://github.com/jwkvam/jupyterlab-vim)

### Voila

Turn jupyter notebooks into (interactive) web pages

[https://blog.jupyter.org/and-voilà-f6a2c08a4a93](https://blog.jupyter.org/and-voil%C3%A0-f6a2c08a4a93)

_Haven't tried it yet_

## Environments
### virtualenv

`venv {directory}` creates a virtual environment for a particular python installation 

### [poetry](https://python-poetry.org)

`poetry` is similar except it creates a file that you can commit to a git repo to version control with dependencies. Additionally, it can be used in lieu of a setup.py file for publishing/building a package.

### [pipenv](https://pipenv.kennethreitz.org)

# logging

## Enable logging for a particular library at a particular level

```python
import logging
l = logging.getLogger("libraryname")
h = logging.StreamHandler(sys.stderr)
f = logging.Formatter('%(levelname)-8s %(name)s - %(message)s')
h.setFormatter(f)
l.setLevel(logging.DEBUG)
l.addHandler(h)
```

## Debugging

### Behold

[behold/README.md at develop · robdmc/behold · GitHub](https://github.com/robdmc/behold/blob/develop/README.md)

Conditional printing

Seems like a way to leave debugging statements in code without having to pass debug options throughout code. With some fancier features for printing things nicely

_Haven't tried it yet_

## Email

Simple email example using localhost smtp server

    # Import smtplib for the actual sending function
    import smtplib
    
    # Import the email modules we'll need
    from email.message import EmailMessage
    
    # Open the plain text file whose name is in textfile for reading.
    with open(textfile) as fp:
        # Create a text/plain message
        msg = EmailMessage()
        msg.set_content(fp.read())
    
    # me == the sender's email address
    # you == the recipient's email address
    msg['Subject'] = 'Email subject'
    msg['From'] = me
    msg['To'] = you
    
    # Send the message via our own SMTP server.
    s = smtplib.SMTP('localhost')
    s.send_message(msg)
    s.quit()

ssl sample

    def send_email(message):
        msg = EmailMessage()
        msg['Subject'] = "Critical Information"
        msg['from'] = "sample@sample.com"
        msg['to'] = "friend@sample.com"
        msg.set_content("Hi")
        context = ssl.create_default_context()
        with smtplib.SMTP("smtp.office365.com") as s:
            s.starttls(context=context)
            s.login("sample@sample.com","sample password")
            s.send_message(msg)

## File locking

This raises and error if it can't acquire the lock. Make sure to keep `lock_f` in scope otherwise python will close the file and release the lock

    lock_file = Path("baljdkasbsda")
    lock_f = lock_file.open("w")
    fcntl.flock(lock_f, fcntl.LOCK_EX | fcntl.LOCK_NB)

## Profiling

[benfred/py-spy](https://github.com/benfred/py-spy) 
This is a sampling profiler. Nice for longer running processes in particular since it has minimal effect on performance because it samples instead of tracking every execution. 

[line_profiler](https://github.com/rkern/line_profiler)
Really nice for looking at execution times for specific functions. Using `@profile` function decorator to select functions 
