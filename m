Return-Path: <cygwin-patches-return-3790-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31726 invoked by alias); 5 Apr 2003 16:45:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31717 invoked from network); 5 Apr 2003 16:45:08 -0000
Message-Id: <3.0.5.32.20030405114536.007ff540@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net
Date: Sat, 05 Apr 2003 16:45:00 -0000
To: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>,
 cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: mkpasswd and mkgroup
In-Reply-To: <20030405162752.41084.qmail@web20007.mail.yahoo.com>
References: <3.0.5.32.20030404195241.007f4a40@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q2/txt/msg00017.txt.bz2

At 08:27 AM 4/5/2003 -0800, Joshua Daniel Franklin wrote:
>--- "Pierre A. Humblet" <Pierre.Humblet@ieee.org> wrote:

>> - allows to specify several domains at once with -d
>
>I just don't understand this one. Can someone be logged into 
>multiple domains at once?
You don't need to be logged in if the domains have a trust
relationship (AFAIK).

>> - only prints SYSTEM and specials when the -l switch is given
>
>Isn't this a rather abrupt change from how these utilities have
>been working? 
Nobody should ever populate /etc/passwd with -d without having
a -l (either concurrent or in a separate call), so SYSTEM will
be there. The current program causes duplicate entries because 
SYSTEM (and others) are added in each call. People have reported
writing scripts to remove duplicates, so I am just trying to be 
nice and avoid having them. 

>Also, please do a patch for utils.sgml explaining the significance
>of the new functionality.
Sure.

Pierre
