Return-Path: <cygwin-patches-return-3508-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11223 invoked by alias); 5 Feb 2003 17:28:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11211 invoked from network); 5 Feb 2003 17:28:16 -0000
Message-Id: <3.0.5.32.20030205122748.007eb480@h00207811519c.ne.client2.attbi.com>
X-Sender: pierre@h00207811519c.ne.client2.attbi.com
Date: Wed, 05 Feb 2003 17:28:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: sec_acl.cc
In-Reply-To: <20030205171317.GZ5822@cygbert.vinschen.de>
References: <3.0.5.32.20030205120201.007ef6c0@h00207811519c.ne.client2.attbi.com>
 <20030205163738.GW5822@cygbert.vinschen.de>
 <3.0.5.32.20030205102239.00805100@h00207811519c.ne.client2.attbi.com>
 <3.0.5.32.20030205091505.007fc270@mail.attbi.com>
 <3.0.5.32.20030205091505.007fc270@mail.attbi.com>
 <3.0.5.32.20030205102239.00805100@h00207811519c.ne.client2.attbi.com>
 <3.0.5.32.20030205112940.00804ab0@h00207811519c.ne.client2.attbi.com>
 <20030205163738.GW5822@cygbert.vinschen.de>
 <3.0.5.32.20030205120201.007ef6c0@h00207811519c.ne.client2.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q1/txt/msg00157.txt.bz2

At 06:13 PM 2/5/2003 +0100, Corinna Vinschen wrote:
>
>When DELETE_CHILD is off on the parent dir, a file with DELETE can be
>removed, a file w/o DELETE can't.

OK, that's what I see with Explorer. However rm will delete it.
That's why I don't think ~DELETE is such a good idea, it only 
affects Windows, not cygwin.

Pierre

