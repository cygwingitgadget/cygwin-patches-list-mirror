Return-Path: <cygwin-patches-return-3496-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16482 invoked by alias); 5 Feb 2003 15:23:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16329 invoked from network); 5 Feb 2003 15:23:27 -0000
Message-Id: <3.0.5.32.20030205102239.00805100@h00207811519c.ne.client2.attbi.com>
X-Sender: pierre@h00207811519c.ne.client2.attbi.com
Date: Wed, 05 Feb 2003 15:23:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: sec_acl.cc
In-Reply-To: <20030205145009.GT5822@cygbert.vinschen.de>
References: <3.0.5.32.20030205091505.007fc270@mail.attbi.com>
 <3.0.5.32.20030205091505.007fc270@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q1/txt/msg00145.txt.bz2

At 03:50 PM 2/5/2003 +0100, Corinna Vinschen wrote:

>> 1) I changed a STANDARD_RIGHTS_ALL to STANDARD_RIGHTS_WRITE in setacl.
>>    Is that what you meant?
>
>I don't know what you mean by "Is that what you meant?".  What are you
>referring to?  However, it's incorrect.  The permission to write does
>include all standard rights.  So the STANDARD_RIGHTS_ALL is correct.

Well, that's more generous than alloc_sd.
In particular Everyone gets the right to change the modes or take ownership,
whenever it gets the right to write.

Pierre
