Return-Path: <cygwin-patches-return-1830-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8185 invoked by alias); 2 Feb 2002 02:27:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8083 invoked from network); 2 Feb 2002 02:27:00 -0000
From: "Gary R Van Sickle" <tiberius@braemarinc.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: For the curious: Setup.exe char-> String patch
Date: Fri, 01 Feb 2002 18:27:00 -0000
Message-ID: <000901c1ab91$0e06d160$2101a8c0@BRAEMARINC.COM>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <001301c1ab8d$fc224f90$0d00a8c0@mchasecompaq>
X-SW-Source: 2002-q1/txt/msg00187.txt.bz2

> +// does this character exist in the string?
> +// 0 is false, 1 is the first position...
> +size_t
> +String::find(char aChar) const
> +{
> +  for (size_t i=0; i < theData->length; ++i)
> +    if (theData->theString[i] == aChar)
> +      return i;
> +  return 0;
>
> ### Won't this return 0 if aChar is in the first position in
> theData->theString?
>

I think it would behoove us greatly to duplicate the semantics of
std::string here, and return a zero-based offset on success, and an "npos"
on failure.


> geturl.cc:
>
>  static void
> -init_dialog (char const *url, int length, HWND owner)
> +init_dialog (String const url, int length, HWND owner)
                ^^^^^^^^^^^^^^^^

This would be better written "const String &url".

--
Gary R. Van Sickle
Braemar Inc.
11481 Rupp Dr.
Burnsville, MN 55337
