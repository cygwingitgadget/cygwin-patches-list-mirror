From: Jason Tishler <jason@tishler.net>
To: Cygwin-Patches <cygwin-patches@sources.redhat.com>
Subject: Minor mkpasswd patch
Date: Fri, 14 Dec 2001 09:13:00 -0000
Message-ID: <20011214121658.A2348@dothill.com>
X-SW-Source: 2001-q4/msg00314.html
Message-ID: <20011214091300.-SSe3CJlH1UjUWpsIQee2eJKRaHmqKN9N0K7Nm2SeYo@z>

The attached fixes a SEGV caused by using the '-p' option:

    $ mkpasswd -d -u jtishler -p /home/jtishler

Jason
