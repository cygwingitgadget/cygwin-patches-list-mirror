Return-Path: <cygwin-patches-return-2563-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27618 invoked by alias); 1 Jul 2002 13:21:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27598 invoked from network); 1 Jul 2002 13:21:12 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Mon, 01 Jul 2002 06:21:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] interruptable accept
In-Reply-To: <20020701144946.I20028@cygbert.vinschen.de>
Message-ID: <Pine.WNT.4.44.0207011513220.375-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q3/txt/msg00011.txt.bz2



On Mon, 1 Jul 2002, Corinna Vinschen wrote:

> On Mon, Jul 01, 2002 at 02:22:36PM +0200, Thomas Pfaff wrote:
> > On Mon, 1 Jul 2002, Corinna Vinschen wrote:
> > > If that helps, look into net.cc, wsock_event::wait().  It's doing
> > > something similar for send/recv.
> >
> > I have already checked, but this for overlapped I/O and can't be used
> > with accept. In a first step i will put all that stuff into the accept
> > call, then you can decide whether it make sense to create new methods.
>
> Sorry if I didn't make this clear enough.  The hint to wsock_event::wait()
> was just to point to an example using multiple events, not to push you
> into the direction of using overlapped IO which obviously don't work
> with accept().

There is another problem with WSAEventSelect. This is winsock2 stuff and
will not run on Win95 without a WIN95 winsock2 update and cygwin1 must
link against ws2_32. I do not think that this is what you want.

Any way, here is an untestet version to see how it could be implemented:

/* exported as accept: standards? */
extern "C" int
cygwin_accept (int fd, struct sockaddr *peer, int *len)
{
  if (peer != NULL
      && (check_null_invalid_struct_errno (len)
	  || __check_null_invalid_struct_errno (peer, (unsigned) *len)))
    return -1;

  int res = -1;
  WSAEVENT ev[2] = { WSA_INVALID_EVENT, signal_arrived };
  BOOL secret_check_failed = FALSE;
  BOOL in_progress = FALSE;
  sigframe thisframe (mainthread);

  fhandler_socket *sock = get (fd);
  if (sock)
    {
      /* Allows NULL peer and len parameters. */
      struct sockaddr_in peer_dummy;
      int len_dummy;
      if (!peer)
	peer = (struct sockaddr *) &peer_dummy;
      if (!len)
	{
	  len_dummy = sizeof (struct sockaddr_in);
	  len = &len_dummy;
	}

      /* accept on NT fails if len < sizeof (sockaddr_in)
       * some programs set len to
       * sizeof (name.sun_family) + strlen (name.sun_path) for UNIX domain
       */
      if (len && ((unsigned) *len < sizeof (struct sockaddr_in)))
	*len = sizeof (struct sockaddr_in);

      if (!sock->is_nonblocking())
        {
          ev[0] = WSACreateEvent ();
          if (WSA_INVALID_EVENT != ev[0] &&
              WSAEventSelect( sock->get_socket (), ev[0], FD_ACCEPT) == 0)
            {
              switch (WSAWaitForMultipleEvents(2, ev, FALSE, WSA_INFINITE,
FALSE))
                {
                case WSA_WAIT_EVENT_0:
                  WSANETWORKEVENTS sock_event;
                  WSAEnumNetworkEvents (sock->get_socket (), ev[0],
&sock_event);
                  if (0 != (sock_event.lNetworkEvents & FD_ACCEPT))
                    {
                      if (sock_event.iErrorCode[FD_ACCEPT_BIT] != 0)
                        {
                          WSASetLastError(
sock_event.iErrorCode[FD_ACCEPT_BIT] );
                          set_winsock_errno ();
                          res = -1;
                          goto done;
                        }
                    }
                  break;
                case WSA_WAIT_EVENT_0 + 1:
                  debug_printf ("signal received during accept");
                  set_errno (EINTR);
                  res = -1;
                  goto done;
                case WSA_WAIT_FAILED:
                default: /* Should be impossible. *LOL* */
                  WSASetLastError (WSAEFAULT);
                  set_winsock_errno ();
                  res = -1;
                  goto done;
                }
            }
        }

      res = accept (sock->get_socket (), peer, len);  // can't use a
blocking call inside a lock

      if ((SOCKET) res == (SOCKET) INVALID_SOCKET &&
	  WSAGetLastError () == WSAEWOULDBLOCK)
	in_progress = TRUE;

      if (sock->get_addr_family () == AF_LOCAL &&
	  sock->get_socket_type () == SOCK_STREAM)
	{
	  if ((SOCKET) res != (SOCKET) INVALID_SOCKET || in_progress)
	    {
	      if (!sock->create_secret_event ())
		secret_check_failed = TRUE;
	      else if (in_progress)
		sock->signal_secret_event ();
	    }

	  if (!secret_check_failed &&
	      (SOCKET) res != (SOCKET) INVALID_SOCKET)
	    {
	      if (!sock->check_peer_secret_event ((struct sockaddr_in*)
peer))
		{
		  debug_printf ("connect from unauthorized client");
		  secret_check_failed = TRUE;
		}
	    }

	  if (secret_check_failed)
	    {
	      sock->close_secret_event ();
	      if ((SOCKET) res != (SOCKET) INVALID_SOCKET)
		closesocket (res);
	      set_errno (ECONNABORTED);
	      res = -1;
	      goto done;
	    }
	}


      cygheap_fdnew res_fd;
      if (res_fd < 0)
	/* FIXME: what is correct errno? */;
      else if ((SOCKET) res == (SOCKET) INVALID_SOCKET)
	set_winsock_errno ();
      else
	{
	  fhandler_socket* res_fh = fdsock (res_fd, sock->get_name (),
res);
	  if (sock->get_addr_family () == AF_LOCAL)
	    res_fh->set_sun_path (sock->get_sun_path ());
	  res_fh->set_addr_family (sock->get_addr_family ());
	  res_fh->set_socket_type (sock->get_socket_type ());
	  res = res_fd;
	}
    }
 done:
  if (WSA_INVALID_EVENT != ev[0])
    {
      if (res != -1)
        {
          // Unset events for newly created socket
          WSAEventSelect (res, ev[0], 0 );
          ioctlsocket (res,FIONBIO,0);
        }
      WSAEventSelect (sock->get_socket (), ev[0], 0 );
      ioctlsocket (sock->get_socket (),FIONBIO,0);
      WSACloseEvent (ev[0]);
    }
  syscall_printf ("%d = accept (%d, %x, %x)", res, fd, peer, len);
  return res;
}



Thomas
