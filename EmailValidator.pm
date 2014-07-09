package EmailValidator;
# Copyright (c) 2014 Agile Technology Engineers Monastery - ATEMON
#
# Git Hub: https://github.com/atemon
# Twitter: https://twitter.com/atemonastery
#
# This file is part of EmailValidator library and distributed under the MIT license (MIT).
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

sub new{
    my ($self) = @_;
    bless {}, $self;
}

sub nslookup_installed{
    my ($self) = @_;
    return `which nslookup` ? 1 : undef;
}

sub valid_mx {
    my ($self, $domain) = @_;
    if ($self->nslookup_installed()) {
        my $rv = `nslookup -query=mx $domain`;
        if( $rv =~ /mail exchanger/ ){
            return 1;
        }
        return undef;
    }
    return undef
}

sub is_valid{
    my ($self, $email) = @_;
    return undef unless $email;
    
    # RFC 3696
    # In addition to restrictions on syntax, there is a length limit on email addresses. 
    # That limit is a maximum of 64 characters (octets) in the "local part" (before the "@") 
    # and a maximum of 255 characters (octets) in the domain part (after the "@") for a total 
    # length of 320 characters. However, there is a restriction in RFC 2821 on the length of 
    # an address in MAIL and RCPT commands of 254 characters. Since addresses that do not fit 
    # in those fields are not normally useful, the upper limit on address lengths should 
    # normally be considered to be 254.

    return undef if length($email) > 254;

    my ($user, $domain, $parts) = split '@', $email;
    return undef if length($user) > 64;
    return undef if length($domain) > 255;
    
    return undef if($parts);
    return undef if( $user !~ /[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+(?:\.[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+)*/i);
    return $self->valid_mx($domain);   #  A valid mail exchange server is configured!
}

1;
