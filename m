Return-Path: <cygwin-patches-return-6517-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14681 invoked by alias); 18 Apr 2009 18:53:49 -0000
Received: (qmail 14665 invoked by uid 22791); 18 Apr 2009 18:53:46 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f173.google.com (HELO mail-ew0-f173.google.com) (209.85.219.173)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 18 Apr 2009 18:53:33 +0000
Received: by ewy21 with SMTP id 21so1339351ewy.2         for <cygwin-patches@cygwin.com>; Sat, 18 Apr 2009 11:53:30 -0700 (PDT)
Received: by 10.210.52.15 with SMTP id z15mr2001000ebz.27.1240080810181;         Sat, 18 Apr 2009 11:53:30 -0700 (PDT)
Received: from ?82.6.108.62? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 7sm5289315eyb.20.2009.04.18.11.53.29         (version=SSLv3 cipher=RC4-MD5);         Sat, 18 Apr 2009 11:53:29 -0700 (PDT)
Message-ID: <49EA242B.9020504@gmail.com>
Date: Sat, 18 Apr 2009 18:53:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: The Return of Revenge of Son of the Speclib Strikes Back :)
References: <49E9DB61.2040506@gmail.com> <20090418173137.GA23840@ednor.casa.cgf.cx>
In-Reply-To: <20090418173137.GA23840@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q2/txt/msg00059.txt.bz2

Christopher Faylor wrote:
> On Sat, Apr 18, 2009 at 02:53:37PM +0100, Dave Korn wrote:

>> The new speclibs libraries work great, but there's one piece of
>> unanticipated fallout: the libtool func_win32_libid() tests can no
>> longer identify them as import libraries.  Which is fair enough, since
>> they aren't, they are now indirect references to import libraries; but
>> we want it to treat them the same anyway.
> 
> I can guess why that is, but it would be nice if you didn't jump right
> to a solution and provided more details.

  Sorry, thought that might be enough.  For the sake of the archives:  We want
to treat these as import libraries, because otherwise libtool says:

*** Warning: linker path does not have real file for library -ldl.
*** I have the capability to make that library automatically link in when
*** you link to this library.  But I can only do this if you have a
*** shared version of the library, which you do not appear to have
*** because I did check the linker path looking for a file starting
*** with libdl and none of the candidates passed a file format test
*** using a file magic. Last file checked: /lib/libdl.a

  We do in fact have a shared version of the library, since anything in a
speclib library refers to a function in the Cygwin DLL.  But because the stubs
in the speclib libraries only indirect to the actual import symbol, libtool
doesn't realise this; the library itself doesn't import anything, and
libtool's test is based on grepping the output of nm to look for a symbol with
" I " in the type field.

>> As usual, I don't speak perl good,
> 
> So, please don't bother sending perl patches.  I can get enough out of
> the description of what is wrong and what your possible solution might
> be to figure out what needs to be done without seeing your
> proof-of-concept.

  Well, it's either harmless extra information, or it will actually clarify
any ambiguities that might exist in my description, so it can't hurt and may
in the event that I mis-speak actually do some good.  There's certainly not
supposed to be any obligation on you to debug it or anything.

> I checked something in which adds a dummy object custom-tailored to the
> each library.
> 
> Thanks for the report.

  Thanks for the fix!

    cheers,
      DaveK
