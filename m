Return-Path: <cygwin-patches-return-3004-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10218 invoked by alias); 19 Sep 2002 14:23:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10203 invoked from network); 19 Sep 2002 14:23:28 -0000
Date: Thu, 19 Sep 2002 07:23:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: More changes about open on Win95 directories.
Message-ID: <20020919142342.GA2293@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020918220225.00810100@mail.attbi.com> <3.0.5.32.20020918220225.00810100@mail.attbi.com> <3.0.5.32.20020919001051.008234e0@h00207811519c.ne.client2.attbi.com> <00ed01c25fb7$1f9f6970$0100a8c0@wdg.uk.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ed01c25fb7$1f9f6970$0100a8c0@wdg.uk.ibm.com>
User-Agent: Mutt/1.4i
X-SW-Source: 2002-q3/txt/msg00452.txt.bz2

On Thu, Sep 19, 2002 at 09:31:34AM +0100, Max Bowsher wrote:
>Pierre A. Humblet wrote:
>> Is '!' invalid? It can easily be confused with '|'.
>
>Maybe ':' ?

Take a look at the context.

>> I am bothered that the code uses 0 as an illegal
>> handle value. Is that really the case?
>
>No.
>/usr/include/w32api/winbase.h:232:#define INVALID_HANDLE_VALUE (HANDLE)(-1)

It really depends on the context.

cgf
