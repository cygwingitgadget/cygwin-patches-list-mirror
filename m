Return-Path: <cygwin-patches-return-1545-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 16013 invoked by alias); 28 Nov 2001 01:19:01 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 15994 invoked from network); 28 Nov 2001 01:19:00 -0000
Reply-To: <nhv@cape.com>
From: "Norman Vine" <nhv@cape.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire stream as a  header
Date: Fri, 26 Oct 2001 07:57:00 -0000
Message-ID: <004801c177ab$13c9f4c0$a300a8c0@nhv>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2232.26
In-Reply-To: <20011127235426.GB6537@redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
X-SW-Source: 2001-q4/txt/msg00077.txt.bz2

Christopher Faylor writes:
>
>On Wed, Nov 28, 2001 at 10:42:33AM +1100, Robert Collins wrote:
>>On Wed, 2001-11-28 at 10:09, Christopher Faylor wrote:
>>> References?  A simple google search for 'NULL C++ deprecated' didn't
>>> unearth this information.
>>
>>Deprecated may have been too strong a word. Anyway, references:
>>
>>The C++ annotations - http://www.icce.rug.nl/documents/cpp.shtml 
>>Specifically...
>>http://www.icce.rug.nl/documents/cplusplus/cplusplus02.html#an78
>
>Thanks for the URL.  This looks like something to bookmark.
>

FWIW
I believe that Standard C requires NULL to be defined in <stddef.h>
http://www.ccs.ucsd.edu/c/stddef.html/#NULL

Cheers

Norman
