Return-Path: <cygwin-patches-return-2865-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 5428 invoked by alias); 26 Aug 2002 08:48:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5414 invoked from network); 26 Aug 2002 08:48:05 -0000
Message-ID: <20020826084803.41470.qmail@web14504.mail.yahoo.com>
Date: Mon, 26 Aug 2002 01:48:00 -0000
From: =?iso-8859-1?q?Danny=20Smith?= <danny_r_smith_2001@yahoo.co.nz>
Subject: Re: [PATCH] winsock related changes for w32api
To: Bart Oldeman <bart.oldeman@btinternet.com>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.LNX.4.33.0208252247200.9978-100000@enm-bo-lt.enm.bris.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SW-Source: 2002-q3/txt/msg00313.txt.bz2

 --- Bart Oldeman <bart.oldeman@btinternet.com> wrote: > On Mon, 26 Aug 2002,
Danny Smith wrote:
> 
> >  --- Bart Oldeman <bart.oldeman@btinternet.com> wrote: > Hi,
> > >
> > > here's a patch adding some winsock, IPX and Netware related definitions.
> > > It was necessary to compile the Watcom Novell debug helper, but can be
> > > useful for others too.
> > >
> > > 2002-08-25  Bart Oldeman  <bart.oldeman@btinternet.com>
> > >
> > > 	* include/nspapi.h (NS_*): Add defines.
> > > 	(SERVICE_*): Add defines.
> > > 	(SERVICE_ADDRESS): Add structure and typedefs.
> > > 	(SERVICE_ADDRESSES): Ditto.
> > > 	(SERVICE_INFO): Ditto.
> > > 	(LPSERVICE_ASYNC_INFO): Add typedef.
> > > 	(SetService, GetAddressByName): Add prototypes.
> >
> > Shouldn't structs and protos  be Unicoded properly, rather than using
> LPTSTR
> 
> LPTSTR should be fine, since:
> <winnt.h>:
> typedef TCHAR *LPTCH,*PTSTR,*LPTSTR,*LP,*PTCHAR;
> and
> #ifdef UNICODE
> typedef WCHAR TCHAR;
> #else
> typedef CHAR TCHAR;
> #endif

No it is not fine. We need explict A and W SERVICE_INFO structure definitions. 

> 
> > Are you sure?  Including wtypes.h can bring in a lot of unnessary COM/OLE
> > through rpc api.
> 
> Well I needed it for BLOB - I saw the same thing happened in winsock2.h,
> which already includes nspapi.h, so I moved the winsock2.h BLOB typedef
> to nspapi.h. and now wtypes.h is not necessary anymore.


This is not fine either. Did you read the FIXME in winsock2.h next to include
#<nspapi.h.>  My reading of the Windows Sockest 2.2 spec is that is not meant
to depend on other api's.  

The FIXME refers to getting rid of dependence of winsock on service provider
api, not reinforcing that dependence

Danny

http://digital.yahoo.com.au - Yahoo! Digital How To
- Get the best out of your PC!
