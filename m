Return-Path: <cygwin-patches-return-2024-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28141 invoked by alias); 4 Apr 2002 05:18:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28127 invoked from network); 4 Apr 2002 05:18:11 -0000
Message-ID: <20020404051811.20957.qmail@web20002.mail.yahoo.com>
Date: Wed, 03 Apr 2002 21:18:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: Re: stackdump.sgml new file
To: cygwin-patches@cygwin.com
In-Reply-To: <20020404045149.GA22318@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2002-q2/txt/msg00008.txt.bz2

> 2) The patch is included is an html attachment.
> 
> Obviously 1) is a no-op but we really need just a straight patch in
> regular text.
> 
Well, I'm not sure this is what you mean, here is the straight text of the
file.
Seems kinda silly for one this short. I put it in stackdump.sgml in
/src/winsup/cygwin/:

<sect1 id="func-cygwin-stackdump">
<title>cygwin_stackdump</title>

<funcsynopsis>
<funcdef>extern "C" void
<function>cygwin_stackdump</function></funcdef>
<void>
</funcsynopsis>

<para> Produce a stackdump from the called location
</para>

</sect1>


__________________________________________________
Do You Yahoo!?
Yahoo! Tax Center - online filing with TurboTax
http://taxes.yahoo.com/
