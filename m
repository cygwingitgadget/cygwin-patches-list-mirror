Return-Path: <cygwin-patches-return-4550-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26541 invoked by alias); 2 Feb 2004 14:47:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26506 invoked from network); 2 Feb 2004 14:47:37 -0000
Message-ID: <401E6307.D7E59AD2@phumblet.no-ip.org>
Date: Mon, 02 Feb 2004 14:47:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [Patch]: ciresrv.parent
References: <3.0.5.32.20040131141848.008138b0@incoming.verizon.net> <3.0.5.32.20040131141848.008138b0@incoming.verizon.net> <3.0.5.32.20040201165730.007f5b30@incoming.verizon.net> <20040202094509.GA16291@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q1/txt/msg00040.txt.bz2



Corinna Vinschen wrote:
> 
> On Feb  1 16:57, Pierre A. Humblet wrote:
> > At 01:39 PM 2/1/2004 -0500, Christopher Faylor wrote:
> > >On Sat, Jan 31, 2004 at 02:18:48PM -0500, Pierre A. Humblet wrote:
> > >>Fortunately it is never used in the case of spawn: all handles are
> > >>inherited, or the parent does the work (sockets).
> > >
> > >The one placed the handle is actually used is in
> > >fhandler_socket::fixup_after_exec.  I'd like Corinna's confirmation
> > >before this patch is checked in.
> >
> > Good idea. FWIW, I checked that one carefully. That's why I found
> > the secret_event bug a while back. I also tested on Win95 with an
> > old winsock.
> > It looks like the handle might be used, but the tests for close
> > on exec always block the paths where it is actually used.
> 
> AFAICS, you're right.  fhandler_socket::fixup_after_exec calls
> fhandler_socket::fixup_after_fork only if !close_on_exec.
> fhandler_socket::fixup_after_fork in turn calls fork_fixup which only
> uses the parent handle if close_on_exec.  So the parent handle is never
> used in this scenario.  So I think it's ok to drop the parent handle.

Do you want to apply the patch now, or I do it this evening?

To simplify the life of future maintainers, I was thinking of
redoing fixup_after_exec as follows
(instead of going through the cascade of calls above)

void
fhandler_socket::fixup_after_exec ()
{
  SOCKET new_sock = WSASocketA (FROM_PROTOCOL_INFO,
				FROM_PROTOCOL_INFO,
				FROM_PROTOCOL_INFO,
				prot_info_ptr, 0, 0);
  debug_printf("%x = WSASocketA(FROM_PROTOCOL_INFO)", new_sock);
  if (new_sock) /* winsock2 */
    set_io_handle ((HANDLE) new_sock);
}
 
> As a side note, it took me a while to understand that it's the same
> situation for the secret_event handle.  The problem is the name of the
> function set_inheritance().  The second parameter is the *negation*
> of the inheritance.  IMHO this is rather confusing.  Either we should
> rename the function to set_no_inheritance or we should revert the
> meaning of the second parameter.

I am all for that! Renaming the function has my preference.

Pierre
