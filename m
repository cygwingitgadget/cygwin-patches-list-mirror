Return-Path: <cygwin-patches-return-3498-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20383 invoked by alias); 5 Feb 2003 16:30:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20368 invoked from network); 5 Feb 2003 16:30:21 -0000
Message-Id: <3.0.5.32.20030205112940.00804ab0@h00207811519c.ne.client2.attbi.com>
X-Sender: pierre@h00207811519c.ne.client2.attbi.com
Date: Wed, 05 Feb 2003 16:30:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: sec_acl.cc
In-Reply-To: <20030205161614.GV5822@cygbert.vinschen.de>
References: <3.0.5.32.20030205102239.00805100@h00207811519c.ne.client2.attbi.com>
 <3.0.5.32.20030205091505.007fc270@mail.attbi.com>
 <3.0.5.32.20030205091505.007fc270@mail.attbi.com>
 <3.0.5.32.20030205102239.00805100@h00207811519c.ne.client2.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q1/txt/msg00147.txt.bz2

At 05:16 PM 2/5/2003 +0100, Corinna Vinschen wrote:
>... I've checked your patch in together with a patch from me.  It
>should now be most similar to alloc_sd().  At least I hope so...

Yes, that's fine. 
However one question remains (in setacl and alloc_sd): 
what good does it do to remove DELETE if unlink() does a
chmod(777) anyway, which puts it back?

Pierre
 
