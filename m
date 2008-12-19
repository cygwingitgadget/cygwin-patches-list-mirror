Return-Path: <cygwin-patches-return-6398-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18421 invoked by alias); 19 Dec 2008 15:28:10 -0000
Received: (qmail 18411 invoked by uid 22791); 19 Dec 2008 15:28:09 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0 	tests=BAYES_00,SARE_MSGID_LONG40,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from yw-out-1718.google.com (HELO yw-out-1718.google.com) (74.125.46.156)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 19 Dec 2008 15:27:34 +0000
Received: by yw-out-1718.google.com with SMTP id 9so444477ywk.38         for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2008 07:27:32 -0800 (PST)
Received: by 10.151.44.15 with SMTP id w15mr1376510ybj.51.1229700452204;         Fri, 19 Dec 2008 07:27:32 -0800 (PST)
Received: by 10.151.12.21 with HTTP; Fri, 19 Dec 2008 07:27:32 -0800 (PST)
Message-ID: <2ce9650b0812190727i5dcfcee9h3398b6140e475431@mail.gmail.com>
Date: Fri, 19 Dec 2008 15:28:00 -0000
From: "Chris January" <chris@atomice.net>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Allow access to /proc/registry/HKEY_PERFORMANCE_DATA
In-Reply-To: <2ce9650b0812190705v520e1be1h779e88196c942b9d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <494BA890.8000004@t-online.de> 	 <2ce9650b0812190705v520e1be1h779e88196c942b9d@mail.gmail.com>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00042.txt.bz2

On Fri, Dec 19, 2008 at 1:58 PM, Christian Franke  wrote:
>        (fhandler_registry::fill_filebuf): Use larger buffer to speed up
>        access to HKEY_PERFORMANCE_DATA values.  Remove check for possible
>        subkey.  Add RegCloseKey ().

+      /* RegQueryValueEx () opens HKEY_PERFORMANCE_DATA.  */
+      RegCloseKey (handle);

I'm slightly puzzled by this change. handle is usually closed in
fhandler_register::close. If you close it here then won't CloseHandle
be called with an invalid handle in that method?

Chris
