Return-Path: <cygwin-patches-return-3736-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28617 invoked by alias); 22 Mar 2003 20:57:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28603 invoked from network); 22 Mar 2003 20:57:46 -0000
Message-Id: <3.0.5.32.20030322155544.007fbb90@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net
Date: Sat, 22 Mar 2003 20:57:00 -0000
To: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>,
 cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Patched doc/setup-net.sgml
In-Reply-To: <20030322201132.GA216@world-gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q1/txt/msg00385.txt.bz2

At 02:11 PM 3/22/2003 -0600, Joshua Daniel Franklin wrote:
>I just committed a big pactch to doc/setup-net.sgml that more or less
>documents setup.exe. Resulting HTML can temporarily be seen at:
>
><http://iocc.com/~joshua/cygwin/setup-net.html>
>
>2003-03-22  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
>
>        * setup-net.sgml: Document setup.exe

Thanks Joshua. Here are three comments

The Root Directory for Cygwin (default C:\cygwin) will become '/' within
your Cygwin installation. 
***
Perhaps add that you must have write access to the parent directory (here
c:\) 
and the inheritances in the acl of the parent will determine the access to
the 
installed files
****

All Windows drives can be accessed with the /cygdrive/X/ virtual directory
and Cygwin's mount utility. 
****
That's not setup related. Delete?
****

The Install For options of All Users or Just Me are especially for
multiuser systems or Domain users. If you have a single-user workstation,
this option probably does not concern you. If you are seeking to rollout
Cygwin on a large Domain, you will want to think carefully about the
implications of each type and possibly consult the Cygwin mailing list
archives about others' experiences.
****
This option is mysterious and the explanation above does not give any food for
thought in "think carefully about the implications". Is it about the mounts
in the 
registry? Anything else? 
Given that the daemons use the system mounts, wouldn't it be a good idea to 
set them?
****

Pierre
