Return-Path: <cygwin-patches-return-3278-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12647 invoked by alias); 4 Dec 2002 20:47:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12628 invoked from network); 4 Dec 2002 20:47:00 -0000
Date: Wed, 04 Dec 2002 12:47:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: PATCH: Implementation of functions in netdb.h
Message-ID: <20021204204751.GA5562@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3DDA4A99.16846.1EEFD0D0@localhost> <3DEE8558.6102.51AEB1@localhost> <20021204135549.D1140@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021204135549.D1140@cygbert.vinschen.de>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00229.txt.bz2

On Wed, Dec 04, 2002 at 01:55:49PM +0100, Corinna Vinschen wrote:
>On Wed, Dec 04, 2002 at 10:44:40PM +1300, Craig McGeachie wrote:
>>N.B.  This routine relies on side effects due to the nature of
>>strtok().  strtok() initially takes a char * pointing to the start of a
>>line, and then NULL to indicate continued processing.  strtok() does
>>not provide a mechanism for getting pointer to the unprocessed portion
>>of a line.  Alias processing is done part way through a line after
>>strtok().  This routine relies on further calls to strtok(), passing
>>NULL as the first parameter, returning alias names from the line.  */
>
>please use strtok_r().  It helps to avoid clashes with the application
>using strtok() as well.

Right.  There are other potential thread problems in this code, too.

However, I've checked it with some minor formatting changes.  I'd
appreciate if you (Craig) would consider making this thread safe.  That
means eliminating the use of statics, for the most part and using
strtok_r, etc.  It's not a simple job by any means but maybe the code in
perthread.h will provide a clue.

Thanks for your contribution, Craig!

cgf
