From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <bkeener@thesoftwaresource.com>, "cygwin-patches" <cygwin-patches@cygwin.com>
Subject: Re: [Patch] setup.exe - change to not ask root on download only.
Date: Tue, 13 Nov 2001 15:49:00 -0000
Message-ID: <01ee01c16c9e$0350bce0$0200a8c0@lifelesswks>
References: <VA.000009d7.011e66c9@thesoftwaresource.com>
X-SW-Source: 2001-q4/msg00216.html
Message-ID: <20011113154900.DaCx5xz4O2PU0XMf4bwJsemO6v6ioh5Tz4rDpTYfqMA@z>

Brian,
can you generate patches with "-up" ? (See the cygwin contributors
page).
It makes it a lot easier to visually grok a patch.

I'll update this for you to the io_streams code for HEAD committing.

Lastly, you were missing a call to get_root_dir_now which resulted in
/etc/setup/last-cache never getting read.

Thanks for this.

Rob
