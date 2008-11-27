Return-Path: <cygwin-patches-return-6359-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10024 invoked by alias); 27 Nov 2008 09:31:02 -0000
Received: (qmail 10004 invoked by uid 22791); 27 Nov 2008 09:31:00 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 27 Nov 2008 09:30:25 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id E08346D4308; Thu, 27 Nov 2008 10:30:23 +0100 (CET)
Date: Thu, 27 Nov 2008 09:31:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Add dirent.d_type support to Cygwin 1.7 ?
Message-ID: <20081127093023.GA9487@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <492DBE7E.7020100@t-online.de> <20081126221012.GA15970@ednor.casa.cgf.cx> <492DD7D0.6050001@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <492DD7D0.6050001@t-online.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00003.txt.bz2

Hi Christian,

On Nov 27 00:12, Christian Franke wrote:
> Christopher Faylor wrote:
>> ...
>>>
>>> +#ifdef _DIRENT_HAVE_D_TYPE
>>> +  /* Set d_type if type can be determined from file attributes.
>>> +     FILE_ATTRIBUTE_SYSTEM ommitted to leave DT_UNKNOWN for old 
>>> symlinks.
>>> +     For new symlinks, d_type will be reset to DT_UNKNOWN below.  */
>>> +  if (attr &&
>>> +      !(attr & ~( FILE_ATTRIBUTE_NORMAL
>>> +                | FILE_ATTRIBUTE_READONLY
>>> +                | FILE_ATTRIBUTE_ARCHIVE
>>> +                | FILE_ATTRIBUTE_HIDDEN
>>> +                | FILE_ATTRIBUTE_COMPRESSED
>>> +                | FILE_ATTRIBUTE_ENCRYPTED
>>> +                | FILE_ATTRIBUTE_SPARSE_FILE
>>> +                | FILE_ATTRIBUTE_NOT_CONTENT_INDEXED
>>> +                | FILE_ATTRIBUTE_DIRECTORY)))

I understand why you omit FILE_ATTRIBUTE_REPARSE_POINT in this attribute
list but what about FILE_ATTRIBUTE_OFFLINE, FILE_ATTRIBUTE_TEMPORARY or,
FWIW, any other new attributes which will be created in later Windows
versions?  Shouldn't this condition test positively instead like, say,

  !(attr & (FILE_ATTRIBUTE_REPARSE_POINT | FILE_ATTRIBUTE_DEVICE))

I must admit I never saw the FILE_ATTRIBUTE_DEVICE attribute actually
set anywhere...

>> This is just checking all of the Windows types but none of the Cygwin
>> types.  Shouldn't it be checking for devices, fifos, and symlinks?
>
> D_type should only be set to the actual type if this info is available at 
> low cost. This is the case for files/dirs, but not for e.g. Cygwin 
> symlinks. Therefore, DT_UNKNOWN is returned instead and the app must call 
> stat() if this info is required.
>
> To speed up typical 'find' and 'ls -R' operations, it is IMO enough to 
> handle the most common filesystem types (for now).

Yeah, without OS support we have no cheap way to recognize other
filetypes.  As the readir man page says, "all applications must properly
handle a return of DT_UNKNOWN."


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
