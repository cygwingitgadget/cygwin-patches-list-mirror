Return-Path: <cygwin-patches-return-4728-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15556 invoked by alias); 7 May 2004 08:12:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15547 invoked from network); 7 May 2004 08:12:54 -0000
Date: Fri, 07 May 2004 08:12:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to handle Win32 named pipes as file names
Message-ID: <20040507081254.GI2201@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <BAY9-F7x9DBFoxhYaf70000ae59@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY9-F7x9DBFoxhYaf70000ae59@hotmail.com>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q2/txt/msg00080.txt.bz2

On May  6 13:45, Stephen Cleary wrote:
> It is a bit more complex than first appears. The problem is that some 
> functions (e.g., SetFilePointer, GetFileInformationByHandle) have undefined 
> behavior when used on pipes (or other special Win32 files). Further, there 
> is no way to determine the type of HANDLE after the fact (GetFileType may 
> work "well enough", but it may not be specific enough for future use).

Keep in mind that supporting Win32 devices untranslated is not our major
concern.  We're fine with supporting them barely.  As I said, as long
as open/read/write/close works, we're "done" (tm).  Lseek and stat are
not exactly important.

> What do you think is the best way to go?

Actually I would rather see an fhandler which implements POSIX FIFOs.
It's not even important if it uses Win32 FIFOs or sockets or any other
underlying transport.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Co-Project Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
