Return-Path: <cygwin-patches-return-2679-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9675 invoked by alias); 22 Jul 2002 06:28:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9657 invoked from network); 22 Jul 2002 06:28:37 -0000
Message-ID: <3D3BA66B.D6C4D145@certum.pl>
Date: Sun, 21 Jul 2002 23:28:00 -0000
From: Jacek Trzcinski <jacek@certum.pl>
Reply-To: jacek@certum.pl
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: /dev/dsp
References: <F1338UJj1Nsjw6u1qzW00015e7e@hotmail.com> <3D38078A.2090409@netscape.net> <20020719155501.Q6932@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00127.txt.bz2

Hi Corinna,
the best way would be to connect any device on serial port which
utilizes both one of output lines(DTR and RTS) and one of input lines
(DSR, CTS, RI,CD) and test it. I do a lot of work with smart card
readers. One of models utilize RTS and CTS line. I tested my patch this
way ( converting my existing Windows reader driver to Cygwin driver)
seting in needed moments RTS line and reading CTS line. All of course by
ioctl() function. I realize You may not have such device but if You have
in Your company any person who is able to prepare D-SUB9 or D-SUB25
female connector( making loops between inputs and outputs) and connect
it to Your male PC serial connector, You will be able to set requested
output lines states and read them by input lines.

Jacek

Corinna Vinschen wrote:
> 
> On Fri, Jul 19, 2002 at 08:35:23AM -0400, Nicholas Wourms wrote:
> > P.S. - Thanks again to Jacek for his serial patch!  Hopefully it will be
> > applied to the sources soon :-).
> 
> Uh, oh, *cough*, are you actually using the serial line from Cygwin?
> I have applied the patch locally and it builds fine but I have no
> idea how to test it.
> 
> Corinna
> 
> --
> Corinna Vinschen                  Please, send mails regarding Cygwin to
> Cygwin Developer                                mailto:cygwin@cygwin.com
> Red Hat, Inc.
