Return-Path: <cygwin-patches-return-3425-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8845 invoked by alias); 19 Jan 2003 00:23:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8817 invoked from network); 19 Jan 2003 00:23:22 -0000
Message-Id: <3.0.5.32.20030118185815.008029d0@h00207811519c.ne.client2.attbi.com>
X-Sender: pierre@h00207811519c.ne.client2.attbi.com
Date: Sun, 19 Jan 2003 00:23:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: etc_changed, passwd & group
In-Reply-To: <20030118234943.GA7895@redhat.com>
References: <3.0.5.32.20030118173700.00802580@h00207811519c.ne.client2.attbi.com>
 <3.0.5.32.20030117233612.007ed390@mail.attbi.com>
 <3.0.5.32.20030118173700.00802580@h00207811519c.ne.client2.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q1/txt/msg00074.txt.bz2

At 06:49 PM 1/18/2003 -0500, Christopher Faylor wrote:
>
>I think I have it fixed in my current sources.  Don't bother.
>
OK, thanks. A thought came to my mind. The current code (as of
last night) was relying on pw_idx starting at 0, and then playing
tricks with subtracting and adding 1. But the same information
is already contained in state (as it should).

If we relied on the state we could put in load ()
if (state != loaded)
   pwd_ix = init ()
without any argument nor +/-1 anywhere. Inside init() 
sawchange[curr_ix] can safely be set to true. 
init() acts as an open(), as you had kind of said. 

Pierre

