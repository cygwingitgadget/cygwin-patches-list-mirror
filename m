Return-Path: <cygwin-patches-return-3471-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19972 invoked by alias); 1 Feb 2003 04:54:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19876 invoked from network); 1 Feb 2003 04:54:10 -0000
Date: Sat, 01 Feb 2003 04:54:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Cc: hzhr@21cn.com
Subject: Re: dlfcn.cc: clear previous dl errors before new dlopen, dlsym, dlclose call?
Message-ID: <20030201045442.GA20981@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, hzhr@21cn.com
References: <3E2D101A.9090607@21cn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E2D101A.9090607@21cn.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00120.txt.bz2

On Tue, Jan 21, 2003 at 05:17:14PM +0800, David Huang wrote:
>Is't needed to clear previous dl errors before new dlopen, dlsym,
>dlclose call?

I don't see anything in the documentation which would indicate this.
However, the current implementation seems to be wrong since it always
returns the last load error even when called repeatedly.

SUSv3 says:

"If no dynamic linking errors have occurred since the last invocation of
dlerror(), dlerror() shall return NULL.  Thus, invoking dlerror() a
second time, immediately following a prior invocation, shall result in
NULL being returned."

So, I've modified dlerror to do just that.

Thanks for bringing this to our attention.

cgf
