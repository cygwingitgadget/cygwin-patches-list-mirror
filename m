Return-Path: <cygwin-patches-return-2681-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24481 invoked by alias); 22 Jul 2002 11:38:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24467 invoked from network); 22 Jul 2002 11:37:59 -0000
Message-ID: <3D3BCF16.4B3F561D@certum.pl>
Date: Mon, 22 Jul 2002 04:38:00 -0000
From: Jacek Trzcinski <jacek@certum.pl>
Reply-To: jacek@certum.pl
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Nicholas Wourms <nwourms@netscape.net>,
   Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: /dev/dsp
References: <F1338UJj1Nsjw6u1qzW00015e7e@hotmail.com> <3D38078A.2090409@netscape.net> <20020719155501.Q6932@cygbert.vinschen.de> <3D3BA66B.D6C4D145@certum.pl> <3D3BE4C2.7060702@netscape.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00129.txt.bz2

I'm not quite sure if minicom is good example for testing all serial
lines. Look that if one choose character transmission from/to serial one
can select flow control by modem lines(RTS-CTS, DTR-DSR). In that case
it does not have to be task of ioctl() function to manipulate mentioned
lines. It should be build in internally in serial deriver and be active
after proper initialisation of serial port. Native Windows serial driver
should do it and Cygwin driver is only responsible for proper
initialization of this native driver. On the other hand minicom sholud
read without problem RI and CD lines and for that it has to utilize
ioctl().

Jacek
Nicholas Wourms wrote:
> 
> Jacek Trzcinski wrote:
> 
> >Hi Corinna,
> >the best way would be to connect any device on serial port which
> >utilizes both one of output lines(DTR and RTS) and one of input lines
> >(DSR, CTS, RI,CD) and test it. I do a lot of work with smart card
> >readers. One of models utilize RTS and CTS line. I tested my patch this
> >way ( converting my existing Windows reader driver to Cygwin driver)
> >seting in needed moments RTS line and reading CTS line. All of course by
> >ioctl() function. I realize You may not have such device but if You have
> >in Your company any person who is able to prepare D-SUB9 or D-SUB25
> >female connector( making loops between inputs and outputs) and connect
> >it to Your male PC serial connector, You will be able to set requested
> >output lines states and read them by input lines.
> >
> In other words, a serial loopback plug, which should be the part of any
> respectable computer technician's toolkit [very useful for verifying the
> integrity of serial ports].  I'm sure the one who works for your RedHat
> branch should have one.  Jacek, shouldn't it also be possible to port
> minicom and use that in conjunction with a modem to see if the signals
> are being sent and recieved?
> 
> Cheers,
> Nicholas
