Return-Path: <cygwin-patches-return-4305-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7139 invoked by alias); 16 Oct 2003 14:08:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7123 invoked from network); 16 Oct 2003 14:08:35 -0000
Date: Thu, 16 Oct 2003 14:08:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Ncurses frame drawing
Message-ID: <20031016140833.GB25076@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20031015082724.GJ14344@cygbert.vinschen.de> <3F8D9621.50601@student.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8D9621.50601@student.tue.nl>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00024.txt.bz2

On Wed, Oct 15, 2003 at 08:46:57PM +0200, Micha Nelissen wrote:
> Corinna Vinschen wrote:
> >Point 2 has some merits.  Are you interested to do that change, Micha?
> >Of course, con_to_str should become a dev_state member then, too.
> 
> Ok, attached is a patch with the requested changes.

Thanks!  Applied with a few tweaks to the ChangeLog entry:

>         * fhandler_console.cc (con_to_str, str_to_con): Move functions to
>         into dev_console class.

Changed to

	* fhandler_console.cc (con_to_str): Move function into dev_console
	class.
	(str_to_con): Ditto.

Otherwise, prepend method names with class names:

>         (read): Call con_to_str on dev_state.

	(fhandler_console::read): ...

etc.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
