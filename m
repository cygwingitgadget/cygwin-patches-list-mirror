From: Christopher Faylor <cgf@redhat.com>
To: Mark Bradshaw <bradshaw@staff.crosswalk.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: patch to mkpasswd.c - allows selection of specific user
Date: Mon, 19 Nov 2001 10:36:00 -0000
Message-ID: <20011119183643.GA1373@redhat.com>
References: <911C684A29ACD311921800508B7293BA010A900F@cnmail>
X-SW-Source: 2001-q4/msg00234.html
Message-ID: <20011119103600.Wwh0-KjKR_EZmbJZz_c6Q0WWCmCnsgVlkBGHTzoukSs@z>

Mark,
We have your assignment on file.

Could you resubmit this patch?

Thanks,
cgf

On Tue, Nov 13, 2001 at 08:09:10AM -0500, Mark Bradshaw wrote:
>Sorry.  I threw that in at the last.  Thought it might be helpful for the
>enduser to get a little feedback for that error.  I'll fix it.
>
>> -----Original Message-----
>> From: Christopher Faylor [ mailto:cgf@redhat.com ] 
>> Sent: Tuesday, November 13, 2001 12:22 AM
>> To: cygwin-patches@cygwin.com
>> Subject: Re: patch to mkpasswd.c - allows selection of specific user
>> 
>> 
>> On Tue, Nov 13, 2001 at 04:02:32PM +1100, Mathew Boorman wrote:
>> >Darn, now I'm told about Marks patch!
>> >Anyway, onward...
>> >
>> >Mark Bradshaw:
>> >
>> >>@@ -135,6 +145,7 @@ enum_users (LPWSTR servername, int print
>> >> 	default:
>> >> 	  fprintf (stderr, "NetUserEnum() failed with %ld\n", rc);
>> >>+	  if ( rc == 2221 ) printf("That user doesn't appear to 
>> exist.\n");
>> >
>> >The appropriate error codes are in <lmerr.h> around, I noted 
>> some were 
>> >slightly different in name though. I believe this message 
>> should go to 
>> >stderr anyway, otherwise you would end up with a polluted 
>> /etc/passwd 
>> >file.
>> 
>> Oops.  This points out a couple of problems that I didn't 
>> notice before.
>> 
>> 1) Never use a raw number like the above, as Mathew has said.
>> 
>> 2) This is not the correct format for an if statement.  You 
>> aren't adhering
>>    to the GNU formatting conventions.  Please use the 
>> formatting of the
>>    code that you are patching.  This is good advice for 
>> whatever project
>>    you are on.
>> 
>> Thanks,
>> cgf
>> 

-- 
cgf@redhat.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
