import React from 'react'
import { render } from 'react-dom';
import { useModal } from 'react-hooks-use-modal';

const UserCard = ({ photo, name, role, address,   }) => {

    const [Modal, open, close, isOpen] = useModal('root', {
        preventScroll: true,
        closeOnOverlayClick: false
    });

    return (
        <div>
          <button onClick={open}>OPEN</button>
          <Modal>
            <div>
              <h1>Title</h1>
              <p>This is a customizable modal.</p>
              <button onClick={close}>CLOSE</button>
            </div>
          </Modal>
        </div>
      )
}

render(<UserCard />, document.getElementById('root'))
export default UserCard