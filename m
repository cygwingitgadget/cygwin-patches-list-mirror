Return-Path: <cygwin-patches-return-2680-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28180 invoked by alias); 22 Jul 2002 10:58:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28166 invoked from network); 22 Jul 2002 10:58:41 -0000
Message-ID: <3D3BE4C2.7060702@netscape.net>
Date: Mon, 22 Jul 2002 03:58:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0rc2) Gecko/20020512 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jacek@certum.pl
CC: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: /dev/dsp
References: <F1338UJj1Nsjw6u1qzW00015e7e@hotmail.com> <3D38078A.2090409@netscape.net> <20020719155501.Q6932@cygbert.vinschen.de> <3D3BA66B.D6C4D145@certum.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00128.txt.bz2

Jacek Trzcinski wrote:

>Hi Corinna,
>the best way would be to connect any device on serial port which
>utilizes both one of output lines(DTR and RTS) and one of input lines
>(DSR, CTS, RI,CD) and test it. I do a lot of work with smart card
>readers. One of models utilize RTS and CTS line. I tested my patch this
>way ( converting my existing Windows reader driver to Cygwin driver)
>seting in needed moments RTS line and reading CTS line. All of course by
>ioctl() function. I realize You may not have such device but if You have
>in Your company any person who is able to prepare D-SUB9 or D-SUB25
>female connector( making loops between inputs and outputs) and connect
>it to Your male PC serial connector, You will be able to set requested
>output lines states and read them by input lines.
>
In other words, a serial loopback plug, which should be the part of any 
respectable computer technician's toolkit [very useful for verifying the 
integrity of serial ports].  I'm sure the one who works for your RedHat 
branch should have one.  Jacek, shouldn't it also be possible to port 
minicom and use that in conjunction with a modem to see if the signals 
are being sent and recieved?

Cheers,
Nicholas
