Return-Path: <cygwin-patches-return-2870-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22816 invoked by alias); 26 Aug 2002 20:51:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22802 invoked from network); 26 Aug 2002 20:51:59 -0000
Message-ID: <20020826205122.89598.qmail@web14507.mail.yahoo.com>
Date: Mon, 26 Aug 2002 13:51:00 -0000
From: =?iso-8859-1?q?Danny=20Smith?= <danny_r_smith_2001@yahoo.co.nz>
Subject: Re: [PATCH] winsock related changes for w32api
To: Bart Oldeman <bart.oldeman@btinternet.com>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.LNX.4.33.0208261813120.17877-100000@enm-bo-lt.enm.bris.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SW-Source: 2002-q3/txt/msg00318.txt.bz2

 --- Bart Oldeman <bart.oldeman@btinternet.com> wrote: > On Mon, 26 Aug 2002,
Danny Smith wrote:
> 
> > No it is not fine. We need explict A and W SERVICE_INFO structure
> definitions.
> 
> OK - I see what you mean and corrected that now.
> 
> > This is not fine either. Did you read the FIXME in winsock2.h next to
> include
> > #<nspapi.h.>  My reading of the Windows Sockest 2.2 spec is that is not
> meant
> > to depend on other api's.
> >
> > The FIXME refers to getting rid of dependence of winsock on service
> provider
> > api, not reinforcing that dependence
> 
> I tried addressing what the FIXME said, by defining a __CSADDR_T_DEFINED
> guard.
> 
> third try...
> 
> Bart
> 
> 2002-08-26  Bart Oldeman  <bart.oldeman@btinternet.com>
> 
>         * include/winsock2.h (SOCKET_ADDRESS): define if
> 	__CSADDR_T_DEFINED is not defined (copied from nspapi.h). Removed
> 	FIXME comment.
>         (CSADDR_INFO): Ditto.
>         * include/nspapi.h (SOCKET_ADDRESS) Only define if
> 	__CSADDR_T_DEFINED is not defined.
> 	(CSADDR_INFO): Ditto.
>         (BLOB): Added structure and typedef if not already defined.
>         (NS_*): Add defines.
>         (SERVICE_*): Ditto.
>         (SERVICE_ADDRESS): Add structure and typedefs.
>         (SERVICE_ADDRESSES): Ditto.
>         (SERVICE_INFO[AW]): Ditto, and add UNICODE mappings.
>         (LPSERVICE_ASYNC_INFO): Add typedef.
>         (SetService[AW], GetAddressByName[AW]): Add prototypes and UNICODE
> 	mappings.
>         * include/wsipx.h: New file.
>         * include/svcguid.h: New file.
> 


This is fine :). Thanks for persevering.

Danny

http://digital.yahoo.com.au - Yahoo! Digital How To
- Get the best out of your PC!
