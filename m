Return-Path: <cygwin-patches-return-3504-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14210 invoked by alias); 5 Feb 2003 16:54:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14192 invoked from network); 5 Feb 2003 16:54:56 -0000
Message-Id: <3.0.5.32.20030205115429.007eca30@h00207811519c.ne.client2.attbi.com>
X-Sender: pierre@h00207811519c.ne.client2.attbi.com
Date: Wed, 05 Feb 2003 16:54:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: sec_acl.cc
In-Reply-To: <20030205163738.GW5822@cygbert.vinschen.de>
References: <3.0.5.32.20030205112940.00804ab0@h00207811519c.ne.client2.attbi.com>
 <3.0.5.32.20030205102239.00805100@h00207811519c.ne.client2.attbi.com>
 <3.0.5.32.20030205091505.007fc270@mail.attbi.com>
 <3.0.5.32.20030205091505.007fc270@mail.attbi.com>
 <3.0.5.32.20030205102239.00805100@h00207811519c.ne.client2.attbi.com>
 <3.0.5.32.20030205112940.00804ab0@h00207811519c.ne.client2.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q1/txt/msg00153.txt.bz2

At 05:37 PM 2/5/2003 +0100, Corinna Vinschen wrote:
>On Wed, Feb 05, 2003 at 11:29:40AM -0500, Pierre A. Humblet wrote:
>> what good does it do to remove DELETE if unlink() does a
>> chmod(777) anyway, which puts it back?
>
>$ touch foo
>$ rm foo
>$ touch foo
>$ chmod u-w foo
>$ rm foo
>rm: remove write-protected file `foo'? y

Yes, but that's the rm command being nice and it is not related
to the DELETE access right.
I am talking about the unlink() function, it plows right through.

Pierre
