From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: patch to mkpasswd.c - allows selection of specific user
Date: Mon, 12 Nov 2001 21:22:00 -0000
Message-ID: <20011113052214.GA27481@redhat.com>
References: <FB7B5F146C8CD5118E0D00306E005CDA02EA5F@AP-CAN-MAIL01>
X-SW-Source: 2001-q4/msg00212.html
Message-ID: <20011112212200.HMsgtfJ5eLBuK-rleKEAFgm6gBya1aSlEj_QSZhdIE0@z>

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
