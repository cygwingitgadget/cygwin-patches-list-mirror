Return-Path: <cygwin-patches-return-1534-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 10294 invoked by alias); 27 Nov 2001 23:41:19 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 10211 invoked from network); 27 Nov 2001 23:41:14 -0000
From: "Gary R Van Sickle" <tiberius@braemarinc.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire stream as a  header
Date: Sun, 21 Oct 2001 16:49:00 -0000
Message-ID: <000001c1779c$e1fe2fa0$2101a8c0@NOMAD>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20011127230925.GA5830@redhat.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2001-q4/txt/msg00066.txt.bz2

> On Wed, Nov 28, 2001 at 09:12:20AM +1100, Robert Collins wrote:
> >On Wed, 2001-11-28 at 05:42, Christopher Faylor wrote:

[snip]

> >I think *l is ok. As for 0 vs NULL, in C++ NULL is
> deprecated, 0 is the
> >correct test for an invalid pointer.
>
> References?  A simple google search for 'NULL C++ deprecated' didn't
> unearth this information.
>

I thought I was getting those Google responses a little faster than usual
;-).  All I could find was a statement by Mr. Stroustrup (sp) indicating
that it was a 'tradition' he liked and wanted to promulgate, nothing
whatsoever about it being deprecated.  (If anyone's wondering, "<ptr> != 0"
is a completely valid and portable construct syntactically).

> Regardless, I strenuously disagree with this.  It certainly is not
> deprecated in the Cygwin DLL.
>

I'm with Chris on this one, again from a self-documenting standpoint if
nothing else.

--
Gary R. Van Sickle
Braemar Inc.
11481 Rupp Dr.
Burnsville, MN 55337
