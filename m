Return-Path: <cygwin-patches-return-5405-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28444 invoked by alias); 6 Apr 2005 05:51:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28143 invoked from network); 6 Apr 2005 05:51:16 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 6 Apr 2005 05:51:16 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 5844B13C961; Wed,  6 Apr 2005 01:51:16 -0400 (EDT)
Date: Wed, 06 Apr 2005 05:51:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] dup_ent does not set dst when src is NULL
Message-ID: <20050406055116.GA10047@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4253768A.8711D94@dessent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4253768A.8711D94@dessent.net>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00001.txt.bz2

On Tue, Apr 05, 2005 at 10:41:30PM -0700, Brian Dessent wrote:
>In net.cc, there are several cases where dup_ent() is used as follows:
>
>dup_ent (servent_buf, getservbyname (name, proto), t_servent);
>syscall_printf ("%p = getservbyname (%s, %s)",
>    _my_tls.locals.servent_buf, name, proto);
>return _my_tls.locals.servent_buf;
>
>This presents a problem if getservbyname() returns NULL, because
>dup_ent just returns NULL, it does not modify 'dst'.  This results in
>the function returning the previous successful value if the
>get_foo_by_bar() function returned NULL.  This seems to be applicable to
>getservbyname(), getservbyport(), gethostbyaddr(), and gethostbyname().  
>
>In the case of gethostbyname() there's also another bug in that there
>will be a spurious debug_printf() about dup_ent failing if the address
>simply didn't resolve.  That should probably be fixed too but I wanted
>to be sure the patch stayed "trivial".

Thanks for the patch, but I went out of my way to avoid freeing the
buffer when I maded changes to dup_ent a couple of weeks ago.  I don't
want to revert to doing that again, so I've just used the return value
in all cases.

cgf
