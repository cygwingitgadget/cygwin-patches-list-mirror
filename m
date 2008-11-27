Return-Path: <cygwin-patches-return-6360-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9337 invoked by alias); 27 Nov 2008 10:39:51 -0000
Received: (qmail 9327 invoked by uid 22791); 27 Nov 2008 10:39:51 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout07.t-online.de (HELO mailout07.t-online.de) (194.25.134.83)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 27 Nov 2008 10:39:05 +0000
Received: from fwd09.aul.t-online.de  	by mailout07.sul.t-online.de with smtp  	id 1L5eH0-0004u6-08; Thu, 27 Nov 2008 11:39:02 +0100
Received: from localhost (XLnhByZSgh5F+uE+HumQfMGS1jKPYuyq1QvRrzuT2+qgwxGuncpqKH-V62-jP+3gn8@[172.20.101.250]) by fwd09.aul.t-online.de 	with esmtp id 1L5eGn-03rme80; Thu, 27 Nov 2008 11:38:49 +0100
MIME-Version: 1.0
Received: from 194.45.13.131:60780 by cmpweb27.aul.t-online.de with HTTP/1.1  (Kommunikationscenter V9-2-23 on API V3-3-16)
In-Reply-To: <20081127093023.GA9487@calimero.vinschen.de>
References: <492DBE7E.7020100@t-online.de>  <20081126221012.GA15970@ednor.casa.cgf.cx> <492DD7D0.6050001@t-online.de>  <20081127093023.GA9487@calimero.vinschen.de>
Date: Thu, 27 Nov 2008 10:39:00 -0000
Reply-To: "Christian Franke" <Christian.Franke@t-online.de>
To: cygwin-patches@cygwin.com
Subject: Re: =?ISO-8859-15?Q?=5BPatch=5D?= Add dirent.d_type support to  Cygwin 1.7 ?
From: "Christian Franke" <Christian.Franke@t-online.de>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <1L5eGn-03rme80@fwd09.aul.t-online.de>
X-ID: XLnhByZSgh5F+uE+HumQfMGS1jKPYuyq1QvRrzuT2+qgwxGuncpqKH-V62-jP+3gn8@t-dialin.net
X-TOI-MSGID: e85fe8ce-d317-400b-9754-9dc25f4407fc
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00004.txt.bz2

Hi Corinna,

Corinna Vinschen wrote:
> > > ...
> > > > 
> > > > +#ifdef _DIRENT_HAVE_D_TYPE
> > > > +  /* Set d_type if type can be determined from file attributes.
> > > > +     FILE_ATTRIBUTE_SYSTEM ommitted to leave DT_UNKNOWN for old
> > > > symlinks.
> > > > +     For new symlinks, d_type will be reset to DT_UNKNOWN
> > > > below.  */ +  if (attr &&
> > > > +      !(attr & ~( FILE_ATTRIBUTE_NORMAL
> > > > +                | FILE_ATTRIBUTE_READONLY
> > > > +                | FILE_ATTRIBUTE_ARCHIVE
> > > > +                | FILE_ATTRIBUTE_HIDDEN
> > > > +                | FILE_ATTRIBUTE_COMPRESSED
> > > > +                | FILE_ATTRIBUTE_ENCRYPTED
> > > > +                | FILE_ATTRIBUTE_SPARSE_FILE
> > > > +                | FILE_ATTRIBUTE_NOT_CONTENT_INDEXED
> > > > +                | FILE_ATTRIBUTE_DIRECTORY)))
> > > > 
> 
> I understand why you omit FILE_ATTRIBUTE_REPARSE_POINT in this
> attribute list but what about FILE_ATTRIBUTE_OFFLINE,
> FILE_ATTRIBUTE_TEMPORARY or, FWIW, any other new attributes which will
> be created in later Windows versions?
> 

FILE_ATTRIBUTE_TEMPORARY and _OFFLINE should be added.


> Shouldn't this condition test positively instead like, say,
> 
> !(attr & (FILE_ATTRIBUTE_REPARSE_POINT | FILE_ATTRIBUTE_DEVICE))
> 

If any undocumented flag is set, then DT_UNKNOWN should be returned. MS
might invent new flags, at least on the ntdll layer.


> I must admit I never saw the FILE_ATTRIBUTE_DEVICE attribute actually
> set anywhere...
> 

Meantime, I found FILE_ATTRIBUTE_VALID_FLAGS in winnt.h. It does not
include FILE_ATTRIBUTE_DEVICE.

I would suggest the following logic:

if (attr)
{
  if (attr & ~FILE_ATTRIBUTE_VALID_FLAGS)
    {
      /* undocumented flag: DT_UNKNOWN
         Probably print a warning once:
        "... please inform cygwin at cygwin.com" */
    }
  else if (!(attr & (FILE_ATTRIBUTE_SYSTEM
                    |FILE_ATTRIBUTE_REPARSE_POINT))
    {
      /* DT_REG or DT_DIR */
    }
  else
    /* possible old symlink or something special: DT_UNKNOWN */;
}

Christian


