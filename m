Return-Path: <cygwin-patches-return-1774-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7539 invoked by alias); 24 Jan 2002 17:49:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7466 invoked from network); 24 Jan 2002 17:49:49 -0000
Date: Thu, 24 Jan 2002 09:49:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com, newlib@sources.redhat.com
Subject: Re: patch to allow newlib to compile when winsup not present
Message-ID: <20020124174949.GA3123@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, newlib@sources.redhat.com
References: <1011834535.1278.46.camel@toggle> <02ce01c1a488$156d32b0$0200a8c0@lifelesswks> <1011892037.16026.53.camel@toggle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1011892037.16026.53.camel@toggle>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00131.txt.bz2

On Thu, Jan 24, 2002 at 12:07:15PM -0500, Thomas Fitzsimmons wrote:
>On Wed, 2002-01-23 at 22:34, Robert Collins wrote:
>> 
>> ===
>> ----- Original Message -----
>> From: "Thomas Fitzsimmons" <fitzsim@redhat.com>
>> To: <cygwin-patches@cygwin.com>
>> Cc: <newlib@sources.redhat.com>
>> Sent: Thursday, January 24, 2002 12:08 PM
>> Subject: patch to allow newlib to compile when winsup not present
>> 
>> 
>> > I've applied this patch to newlib, so that it will compile for the
>> > i686-pc-cygwin target, when winsup is not in the source tree.
>> > Previously, the newlib build failed because pthread_t was undefined.
>> 
>> This is incorrect. Cygwin has pthread_kill, so you _will need_ the
>> cygwin header files to compile newlib for i686-pc-cygwin, regardless of
>> having winsup in the source tree or not.
>> 
>
>Then would a better solution be to include
>winsup/cygwin/include/cygwin/types.h in the newlib distribution?

What's wrong with saying that you need the winsup directory or a cygwin
installation to compile the cygwin versions of newlib?

cgf
