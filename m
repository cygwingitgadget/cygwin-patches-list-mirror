Return-Path: <cygwin-patches-return-2879-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17908 invoked by alias); 28 Aug 2002 15:50:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17893 invoked from network); 28 Aug 2002 15:50:22 -0000
Date: Wed, 28 Aug 2002 08:50:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Readv/writev patch
Message-ID: <20020828155017.GG4346@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <01aa01c24dda$cc5384b0$6132bc3e@BABEL> <20020828123735.B10870@cygbert.vinschen.de> <000301c24ea4$dc61b870$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000301c24ea4$dc61b870$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00327.txt.bz2

On Wed, Aug 28, 2002 at 03:59:42PM +0100, Conrad Scott wrote:
>> I also don't like these C++ cast operators since the Plain-C casts
>>are doing quite the same but are way easier to read.  Perhaps I'm just
>>old-fashioned.
>
>I rather prefer the C++ cast operators since they're both clearer and
>safer: e.g.  using a const_cast guarantees that that all you're doing
>is removing the const-ness of something.  I've seen too many bugs
>before now where someone's added a cast (just to remove a const or
>something simple) and then changed the underlying object's type
>elsewhere and the cast still works with no complaint yet is now not
>doing the right thing at all.  If you're feeling determinedly
>old-fashioned I'll take them out but you will have to realise that it
>will be with great pain and suffering on my part :-)

Sorry, but I'm with Corinna on this one.  I'd rather keep the code
consistent.

cgf
