Return-Path: <cygwin-patches-return-3505-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19056 invoked by alias); 5 Feb 2003 17:02:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19040 invoked from network); 5 Feb 2003 17:02:30 -0000
Message-Id: <3.0.5.32.20030205120201.007ef6c0@h00207811519c.ne.client2.attbi.com>
X-Sender: pierre@h00207811519c.ne.client2.attbi.com
Date: Wed, 05 Feb 2003 17:02:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: sec_acl.cc
In-Reply-To: <20030205164507.GX5822@cygbert.vinschen.de>
References: <20030205163738.GW5822@cygbert.vinschen.de>
 <3.0.5.32.20030205102239.00805100@h00207811519c.ne.client2.attbi.com>
 <3.0.5.32.20030205091505.007fc270@mail.attbi.com>
 <3.0.5.32.20030205091505.007fc270@mail.attbi.com>
 <3.0.5.32.20030205102239.00805100@h00207811519c.ne.client2.attbi.com>
 <3.0.5.32.20030205112940.00804ab0@h00207811519c.ne.client2.attbi.com>
 <20030205163738.GW5822@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q1/txt/msg00154.txt.bz2

At 05:45 PM 2/5/2003 +0100, Corinna Vinschen wrote:

>But still, it's more correct, isn't it.
That's opinion, not fact! It's also relatively convoluted code that does
little, or perhaps even nothing! 

>Surprise, surprise.  I've just tried to delete a file in Explorer with
>the DELETE bit unset and there's *no* difference in behaviour at all.
How was the DELETE_FILE (or whatever the name) permission on the directory?
I tried here and got an error message.

Pierre
