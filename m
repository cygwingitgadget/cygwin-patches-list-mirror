Return-Path: <cygwin-patches-return-1484-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 28104 invoked by alias); 13 Nov 2001 05:22:22 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 28043 invoked from network); 13 Nov 2001 05:22:12 -0000
Date: Mon, 08 Oct 2001 16:30:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: patch to mkpasswd.c - allows selection of specific user
Message-ID: <20011113052214.GA27481@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <FB7B5F146C8CD5118E0D00306E005CDA02EA5F@AP-CAN-MAIL01>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FB7B5F146C8CD5118E0D00306E005CDA02EA5F@AP-CAN-MAIL01>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2001-q4/txt/msg00016.txt.bz2

On Tue, Nov 13, 2001 at 04:02:32PM +1100, Mathew Boorman wrote:
>Darn, now I'm told about Marks patch!
>Anyway, onward...
>
>Mark Bradshaw:
>
>>@@ -135,6 +145,7 @@ enum_users (LPWSTR servername, int print
>> 	default:
>> 	  fprintf (stderr, "NetUserEnum() failed with %ld\n", rc);
>>+	  if ( rc == 2221 ) printf("That user doesn't appear to exist.\n");
>
>The appropriate error codes are in <lmerr.h> around, I noted some were
>slightly different in name though.
>I believe this message should go to stderr anyway, otherwise you would end
>up with a polluted /etc/passwd file.

Oops.  This points out a couple of problems that I didn't notice before.

1) Never use a raw number like the above, as Mathew has said.

2) This is not the correct format for an if statement.  You aren't adhering
   to the GNU formatting conventions.  Please use the formatting of the
   code that you are patching.  This is good advice for whatever project
   you are on.

Thanks,
cgf
