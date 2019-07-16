# view
Take a Camera Image &amp; send to [MONITOR](https://monitor.uedasoft.com) server

<img src="https://2.bp.blogspot.com/-8CMvYEOuTHQ/W5TLvCskH2I/AAAAAAAAAlU/Sa6NpowqP6c4LHc9ugB4ptble9jM8v9kQCLcBGAs/s1600/2018-09-09%2B14.32.32.jpg" width="18%">
<img src="https://1.bp.blogspot.com/-d4U3cNRTDnw/W5TUf6tNFZI/AAAAAAAAAmI/ouhvzpklIf0W9Xv2TOC8gv5_cd1ip6GKQCEwYBhgL/s1600/2018-09-09%2B14.35.28.jpg" width="48%">
<img src="https://2.bp.blogspot.com/-YK5AM3oT8ko/W5TMuSoknsI/AAAAAAAAAls/ZP3Fk2QNLKU86yiXuqkW6Lei1OVcGFA3QCEwYBhgL/s1600/2018-09-09%2B14.37.10.png" width="28%">

This ***view*** module provide 3 features:
- view.sh: Take Camera Image & send to the [MONITOR](https://monitor.uedasoft.com) server
- autostart.sh: RUn view.sh at 5 minutes interval.
- hdc_autostart.sh: Run view.sh with outside event by GPIO, like PIR(Passive Infra-Red) Human detection Sensor.

## 1. Install
download from [release](https://github.com/UedaTakeyuki/view/releases)

or 

```
git clone https://github.com/UedaTakeyuki/view2.git
```

## 2. 2etup
Install & setup prerequired modules by

```
cd view2
./setup.sh 
```

## 3. Get free acount of MONITOR™ service
By Web Browser, Sign up to MONITOR™ Service at [here](https://monitor3.uedasoft.com/index.mdl.php). Following Quick Start document of [Sign up to Monitor](https://monitor.uedasoft.com/docs/UserGuide/Signup.html) might be informative.

## 4. confirm your view_id on the MONITOR™
Sign up/in to MONITOR™ and confirm your view_id on the top page as follows:

<img src="https://monitor.uedasoft.com/docs/UserGuide/pics/2018-08-19.12.39.26-2.png" width="28%">

## 5. set view_id
Return back to view on the console, set view_id mentioned above by ***setid.sh*** command.
Let's say your view_id is axwdjqwy as above picture, set it by setid.sh as

```
./setid.sh axwdjqwy
```

## 6. test

###Test to take & send photo

After view_id setting is finished, you can take & send photo by following command.

```
python -m pondslider
```

You may see following sequence of log.

```
{'photo': '/tmp/20190625210920.jpg'}
start handle
end handle
call value handler
start terminate
end terminate
```

By Web Browser, you can see the MONITOR™ display is updated by your taken & sent photo.

<img src="https://monitor.uedasoft.com/docs/UserGuide/pics/2018-09-03.16.32.22.png" width="28%">


## 7. setting for automatically run view.sh at 5 minute interval

You can set that view.sh is called repeatedly at 5 minute interval after device is turned on by autostart.sh command as follows:

```
# set autostart on
./autostart.sh --on

# set autostart off
./autostart.sh --off
```

Technically speaking, autostart.sh set timer service of systemctl for view.sh. In case you are familiar with crontab, it's OK to set view.sh on the cron yourself instead of using autostart command.

You can confirm current status with --status option:

```
./autostart.sh --status
```

You may see following sequence:

```
./autostart.sh --status
● view2.service - Take photos & Post to the monitor
   Loaded: loaded (/home/pi/SCRIPT/view2/view2.service; enabled; vendor preset: enabled)
   Active: active (running) since Tue 2019-06-25 21:13:00 JST; 8s ago
 Main PID: 830 (sudo)
   CGroup: /system.slice/view2.service
           ├─830 /usr/bin/sudo /usr/bin/python -m pondslider --interval 5
           ├─837 /usr/bin/python -m pondslider --interval 5
           ├─838 /bin/sh -c fswebcam /tmp/20190625211306.jpg -d /dev/video0 -D 1 -S 20 -r 320x240
           └─839 fswebcam /tmp/20190625211306.jpg -d /dev/video0 -D 1 -S 20 -r 320x240

Jun 25 21:13:00 raspberrypi systemd[1]: Started Take photos & Post to the monitor.
Jun 25 21:13:00 raspberrypi sudo[830]:     root : TTY=unknown ; PWD=/home/pi/SCRIPT/view2 ; USER=root ; COMMAND=/usr/bin/pytho
Jun 25 21:13:00 raspberrypi sudo[830]: pam_unix(sudo:session): session opened for user root by (uid=0)
```

In case waiting key input, type "q" key.

In case afte service set as off, you can see followings:
```
Unit view2.service could not be found.
```

## 8. setting for automatically run view.sh with outside event by GPIO, like PIR(Passive Infra-Red) Human detection Sensor.

Instead of periodical running menttioned above step 5, you can set [GPIO Event trigger](https://github.com/UedaTakeyuki/view/wiki/GPIO-Event-trigger)  by ***hdc.sh***. hdc.sh runs as event loop to wach GPIO level change and kick ***view.sh***. You can also set hdc.sh as service by ***hdc_autostart.sh*** as follows. 

```
# set autostart on
./hdc_autostart.sh --on

# set autostart off
./hdc_autostart.sh --off
```

You can confirm current status with --status option:

```
./hdc_autostart.sh --status
```

You may see the following sequence:

```
● view.service - Take photos & Post to the monitor
   Loaded: loaded (/home/pi/view/view.service; enabled; vendor preset: enabled)
   Active: activating (auto-restart) since Wed 2018-11-14 21:01:52 JST; 25s ago
  Process: 7947 ExecStart=/home/pi/view/view.sh (code=exited, status=0/SUCCESS)
 Main PID: 7947 (code=exited, status=0/SUCCESS)
   CGroup: /system.slice/view.service
```

In case afte service set as off, you can see followings:
```
pi@raspberrypi:~/view $ ./hdc_autostart.sh --status
Unit view.service could not be found.
```

### 8.1 Example usage of PIR (Passive Infrared Ray) Human Detection Sensor
- [Blog Post](https://monitorserviceatelierueda.blogspot.com/2018/09/how-to-make-human-detection-security.html).
- [wiki](https://github.com/UedaTakeyuki/view/wiki/PIR-(Passive-Infrared-Ray)-Human-Detection-Sensor)


## 9. Blog posts

#### for version 1.2.0 or later
- [How to make Human Detection Security camera with under 1$ Human Detection Senser, 2$ USB Webam & Raspberry Pi](https://monitorserviceatelierueda.blogspot.com/2018/09/how-to-make-human-detection-security.html)

#### for version 1.1.1 or later
- [How to make Security camera with 2$ USB Webam & Raspberry Pi](https://monitorserviceatelierueda.blogspot.com/2018/09/how-to-make-security-camera-with-2-usb.html)
- [How to make Security camera with 2$ USB Webam & Beagle Bone Green 
](https://monitorserviceatelierueda.blogspot.com/2018/09/how-to-make-security-camera-with-2-usb_18.html)

#### for general
- [What is MONITOR?](https://monitorserviceatelierueda.blogspot.com/p/monitor.html)

## 10. Q&A
Any questions, suggestions, reports are welcome! Please make [issue](https://github.com/UedaTakeyuki/view/issues) without hesitation! 

## 11. history
- 0.1.0  2018.12.06  first version self-forked from [view](https://github.com/UedaTakeyuki/view).
