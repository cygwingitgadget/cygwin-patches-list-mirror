Return-Path: <cygwin-patches-return-3195-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1184 invoked by alias); 15 Nov 2002 20:25:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1175 invoked from network); 15 Nov 2002 20:25:40 -0000
Message-ID: <000e01c28ce4$cf672230$0201a8c0@sos>
From: "Sergey Okhapkin" <sos@prospect.com.ru>
To: "Nicholas Wourms" <nwourms@netscape.net>
Cc: "Cygwin-Patches" <cygwin-patches@cygwin.com>
References: <041a01c28cd7$7ffbf070$0201a8c0@sos> <3DD54E46.9020605@netscape.net>
Subject: Re: select on serial fix
Date: Fri, 15 Nov 2002 12:25:00 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Virus-Scanned: by amavisd-milter (http://amavis.org/)
X-SW-Source: 2002-q4/txt/msg00146.txt.bz2

So... Do it!-)

Sergey Okhapkin
Somerset, NJ
----- Original Message -----
From: "Nicholas Wourms" <nwourms@netscape.net>
To: "Sergey Okhapkin" <sos@prospect.com.ru>
Cc: "Cygwin-Patches" <cygwin-patches@cygwin.com>
Sent: Friday, November 15, 2002 2:43 PM
Subject: Re: select on serial fix


> Sergey Okhapkin wrote:
> > The patch fixes a problem with a characters loss on select on a serial
port.
> > I wonder what PurgeComm() calls in the original code supposed to do...
> >
> >
>
> If you're feeling motivated, mkfifo() still needs
> implimenting ;-).
>
> Cheers,
> Nicholas
>
>
>
>

