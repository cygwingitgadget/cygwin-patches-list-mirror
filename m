Return-Path: <cygwin-patches-return-5239-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26754 invoked by alias); 17 Dec 2004 18:42:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26731 invoked from network); 17 Dec 2004 18:42:53 -0000
Received: from unknown (HELO EXCHANGE.atl.air2web.com) (12.39.48.67)
  by sourceware.org with SMTP; 17 Dec 2004 18:42:53 -0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: Patch to allow trailing dots on managed mounts
Date: Fri, 17 Dec 2004 18:42:00 -0000
Message-ID: <C1A7FA5F2793A94BA223673B8ADAF4A1037463C9@exchange.air2web.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "Richard Campbell" <richard.campbell@air2web.com>
To: <cygwin-patches@cygwin.com>
X-SW-Source: 2004-q4/txt/msg00240.txt.bz2

cgf wrote:
>
>It does seem to allow
>dir c:\cygwin\bin.\ls.exe

The following succeed (windows 2000):
dir c:\cygwin\bin\ls.exe
dir c:\cygwin\bin.\ls.exe
dir c:\cygwin\bin..\ls.exe
dir c:\cygwin\bin\ls.exe.
dir c:\cygwin\bin\ls.exe..
dir c:\cygwin\bin\ls.exe...
dir c:\cygwin\bin\ls.exe....
dir c:\cygwin.\bin\ls.exe
dir c:\cygwin.\bin.\ls.exe
dir c:\cygwin.\bin..\ls.exe
dir c:\cygwin.\bin.\ls.exe....

The following fail:
dir c:\cygwin..\bin\ls.exe
dir c:\cygwin.\bin...\ls.exe

Strangely inconsistent about the number of dots based on=20
position in a path.

-Richard Campbell.
