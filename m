Return-Path: <cygwin-patches-return-3789-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27437 invoked by alias); 5 Apr 2003 16:27:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27426 invoked from network); 5 Apr 2003 16:27:52 -0000
Message-ID: <20030405162752.41084.qmail@web20007.mail.yahoo.com>
Date: Sat, 05 Apr 2003 16:27:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: Re: mkpasswd and mkgroup
To: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>, cygwin-patches@cygwin.com
In-Reply-To: <3.0.5.32.20030404195241.007f4a40@mail.attbi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2003-q2/txt/msg00016.txt.bz2

--- "Pierre A. Humblet" <Pierre.Humblet@ieee.org> wrote:
> Corinna,

Hmm. I feel like I'm eavesdropping.

> Following remarks made on the list this patch
> - allows to specify several domains at once with -d

I just don't understand this one. Can someone be logged into 
multiple domains at once?

> - only prints SYSTEM and specials when the -l switch is given

Isn't this a rather abrupt change from how these utilities have
been working? 

Also, please do a patch for utils.sgml explaining the significance
of the new functionality.

__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - File online, calculators, forms, and more
http://tax.yahoo.com
