Return-Path: <cygwin-patches-return-3421-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3836 invoked by alias); 18 Jan 2003 05:09:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3827 invoked from network); 18 Jan 2003 05:09:08 -0000
Message-Id: <3.0.5.32.20030118000310.007fc7c0@h00207811519c.ne.client2.attbi.com>
X-Sender: pierre@h00207811519c.ne.client2.attbi.com
Date: Sat, 18 Jan 2003 05:09:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: etc_changed, passwd & group
In-Reply-To: <3.0.5.32.20030117233612.007ed390@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q1/txt/msg00070.txt.bz2

Chris,

An ugly tought came to my mind while doing the dishes:
there is a race condition left.
FindFirstChangeNotification must be called from init, otherwise
in the normal case it will be called after the load, leaving
a window where the file can be updated without being noticed.

Similarly in the fork case, where changed_dir is called first,
FindFirstChangeNotification must be called from changed_dir
(if the handle is NULL), even though res will be true.

I guess this calls for defining a new function en etc::, calling
it both from init and changed_dir. 
Enough for today, good night.

Pierre
   
