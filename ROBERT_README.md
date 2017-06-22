# Process

I began by reading the spec and understanding the requirements of the project. I made a database schema for what I wanted, determining that I wanted to create an `inquiries` join table that had a `unit_id` and a `user_id`. From there, I made migrations for a quick `User` model as well as an `Inquiry` model and built out a controller that allowed bookings by clicking on `Units` from a unit index url. This would link to a unit show url, which doubled as an inquiry new url. From there, an inquiry was made and it redirected to the inquiry edit url, which doubled as an inquiry show url with a delete button.

After generating these pages, I wrote some tests to test models and controllers, and applied rudimentary CSS on top of the scaffold.

# Notes

Errors are thrown and printed when CRUD operations are performed on Inquiries. There are rudimentary passes at user authentication (via entering their e-mail address to update or delete). There's also error checking for overlapping inquiry dates.

# Problems

So, I couldn't figure out how to make association data available to models inside rspec tests. I therefore couldn't get a lot of my Inquiry model tests to function. That was difficult to swallow, since that was the actual challenging one.

I also had CSS conflicts that actually interfered with the rendering of erb. I didn't even know that was possible, yet I managed it. The `error_explanation` div in the scaffolds.css kept not even appearing on the page when I tried to incorporate it into flex layouts. I think this had something to do with its width or height definitions but I couldn't figure it out in time. All the CSS is therefore commented out because seeing errors was more important than having better layout.

# To Do

If I had had more time, I would have covered the following.

## Make tests work

If I had had time, I would make Inquiry tests that worked. Yikes. I would also attempt to write view tests with Capybara (which I definitely need to refresh myself on).

## Fix CSS

I have no idea why my CSS is interfering with the actual rendering of erb. It is totally crazy and I would need to do some research on why that might be happening.

## Database and model validations on inquiry dates

I can't believe I didn't check if start_date was before end_date. Also, if you inquire for a unit with no price on that day, it shouldn't be free.

## True authentication

Finding a user's e-mail basically lets you do whatever. Because e-mails are stored on the database unencrypted, they're quite vulnerable. Encrypting e-mails and using session tokens would be a useful thing to do.
